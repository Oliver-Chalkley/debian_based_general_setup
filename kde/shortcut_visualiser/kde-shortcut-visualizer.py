#!/usr/bin/env python3
"""KDE Plasma keyboard shortcuts visualization tool with categorical grouping and grid layout."""

import argparse
import configparser
import logging
import pathlib
import sys
from typing import Dict, List, Optional, Set

from graphviz import Digraph
from pydantic import BaseModel, Field, field_validator
from pydantic.color import Color

# Configure logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


class ShortcutParsingError(Exception):
    """Raised when there's an error parsing the shortcuts file."""


class ConfigurationError(Exception):
    """Raised when there's an error in the configuration settings."""


class ShortcutCategory(BaseModel):
    """Model for shortcut categories and their colors."""

    name: str
    color: str
    patterns: Set[str]


# Define shortcut categories and their patterns
SHORTCUT_CATEGORIES = [
    ShortcutCategory(
        name="Window Actions",
        color="#E6194B",  # Red
        patterns={"Window Close", "Window Move", "Window Resize", "Kill Window"},
    ),
    ShortcutCategory(
        name="Window Positioning",
        color="#3CB44B",  # Green
        patterns={"Window Pack", "Window Quick Tile", "Window Center", "Window to"},
    ),
    ShortcutCategory(
        name="Window State",
        color="#FFE119",  # Yellow
        patterns={
            "Window Maximize",
            "Window Minimize",
            "Window Fullscreen",
            "Window Shade",
        },
    ),
    ShortcutCategory(
        name="Window Focus",
        color="#4363D8",  # Blue
        patterns={"Switch Window", "Walk Through Windows"},
    ),
    ShortcutCategory(
        name="Desktop Navigation",
        color="#F58231",  # Orange
        patterns={"Switch to Desktop", "Switch One Desktop"},
    ),
    ShortcutCategory(
        name="Desktop Overview",
        color="#911EB4",  # Purple
        patterns={"Show Desktop", "ShowDesktopGrid", "Expose", "Overview"},
    ),
    ShortcutCategory(
        name="Screen Control",
        color="#42D4F4",  # Cyan
        patterns={"Screen", "Monitor"},
    ),
    ShortcutCategory(
        name="System Actions",
        color="#F032E6",  # Magenta
        patterns={"Suspend Compositing", "Toggle"},
    ),
]


class VisualizationConfig(BaseModel):
    """Configuration settings for the visualization."""

    rankdir: str = Field(
        default="TB",  # Changed default to top-to-bottom for better category layout
        description="Graph layout direction (LR=left-to-right, TB=top-to-bottom)",
        pattern="^(LR|TB)$",
    )
    node_shape: str = Field(
        default="box", description="Shape of the nodes (box, circle, ellipse, etc.)"
    )
    node_style: str = Field(
        default="rounded",
        description="Style of the nodes (rounded, filled, dashed, etc.)",
    )
    font_family: str = Field(default="Arial", description="Font family for text")
    background_color: Color = Field(
        default="lightgrey",
        description="Background color for clusters (name or hex code)",
    )
    output_format: str = Field(
        default="png", description="Output file format (svg, pdf, png, jpg)"
    )
    dpi: str = Field(default="300", description="DPI for PNG output")

    @field_validator("output_format")
    @classmethod
    def validate_output_format(cls, v: str) -> str:
        """Validate that the output format is supported by GraphViz."""
        supported_formats = {"svg", "pdf", "png", "jpg"}
        if v.lower() not in supported_formats:
            raise ValueError(
                f"Unsupported output format. Must be one of: {supported_formats}"
            )
        return v.lower()

    model_config = {
        "validate_assignment": True,
        "extra": "forbid",
    }


class ShortcutMapping(BaseModel):
    """Model for storing keyboard shortcuts."""

    shortcuts: Dict[str, Dict[str, str]] = Field(
        default_factory=dict, description="Nested dictionary of shortcuts by section"
    )


class ShortcutVisualizer:
    """A class to visualize KDE Plasma keyboard shortcuts."""

    def __init__(
        self, file_path: str, config: Optional[VisualizationConfig] = None
    ) -> None:
        """Initializes the ShortcutVisualizer."""
        self.config = config or VisualizationConfig()
        self.shortcuts = ShortcutMapping()

        file_path_obj = pathlib.Path(file_path)
        if not file_path_obj.exists():
            raise FileNotFoundError(f"Shortcuts file not found: {file_path}")

        try:
            self._parse_shortcuts_file(file_path_obj)
        except configparser.Error as e:
            raise ShortcutParsingError(f"Failed to parse shortcuts file: {e}")

    def _parse_shortcuts_file(self, file_path: pathlib.Path) -> None:
        """Parses the KDE shortcuts configuration file."""
        logger.info("Parsing shortcuts file: %s", file_path)
        config_parser = configparser.ConfigParser()

        try:
            config_parser.read(file_path)
            logger.info(
                "Found %d sections in config file", len(config_parser.sections())
            )

            parsed_shortcuts = {}
            for section in config_parser.sections():
                logger.debug("Processing section: %s", section)
                section_shortcuts = {}

                for key, value in config_parser[section].items():
                    # Check for multiple shortcuts separated by semicolons
                    shortcuts = [s.strip() for s in value.split(";")]
                    # Filter out empty shortcuts
                    valid_shortcuts = [s for s in shortcuts if s and s != "none"]

                    if valid_shortcuts:
                        logger.debug(
                            "  Found shortcut: %s -> %s",
                            key,
                            ", ".join(valid_shortcuts),
                        )
                        section_shortcuts[key] = " or ".join(valid_shortcuts)

                # Only add sections that have shortcuts defined
                if section_shortcuts:
                    logger.info(
                        "Adding section %s with %d shortcuts",
                        section,
                        len(section_shortcuts),
                    )
                    parsed_shortcuts[section] = section_shortcuts
                else:
                    logger.debug("Skipping empty section: %s", section)

            self.shortcuts.shortcuts = parsed_shortcuts
            logger.info(
                "Successfully parsed %d sections with shortcuts",
                len(self.shortcuts.shortcuts),
            )

        except Exception as e:
            raise ShortcutParsingError(f"Error parsing shortcuts: {e}")

    def generate_visualization(self, output_path: str) -> None:
        """Generates a visual representation of the shortcuts."""
        logger.info("Generating visualization at: %s", output_path)

        if not self.shortcuts.shortcuts:
            logger.error("No shortcuts found to visualize!")
            raise ConfigurationError("No shortcuts found in the input file")

        try:
            dot = self._create_graph()
            output_file = pathlib.Path(output_path)

            # Configure for PNG output
            if self.config.output_format == "png":
                dot.attr(dpi=self.config.dpi)

            # Generate the visualization
            output_path = dot.render(
                str(output_file), format=self.config.output_format, cleanup=True
            )

            logger.info("Visualization saved to: %s", output_path)

        except Exception as e:
            raise ConfigurationError(f"Failed to generate visualization: {e}")

    def _create_graph(self) -> Digraph:
        """Creates the GraphViz diagram with the shortcuts."""
        dot = Digraph(comment="KDE Shortcuts Visualization")

        # Configure global graph attributes for a more compact layout
        dot.attr(rankdir=self.config.rankdir)
        dot.attr(
            "node",
            shape=self.config.node_shape,
            fontname=self.config.font_family,
            margin="0.2",
            height="0.3",
            width="2.5",
        )
        dot.attr(
            "graph",
            fontname=self.config.font_family,
            ranksep="0.3",
            nodesep="0.2",
            pad="0.5",
            splines="ortho",
            concentrate="true",
            compound="true",
        )

        # First, collect all categories with their shortcuts to determine sizes
        category_data = []
        for category in SHORTCUT_CATEGORIES:
            category_shortcuts = []
            for section, bindings in self.shortcuts.shortcuts.items():
                for key, value in bindings.items():
                    if any(
                        pattern.lower() in key.lower() for pattern in category.patterns
                    ):
                        node_id = f"{section}_{key}"
                        label = f"{key}\n{value}"
                        category_shortcuts.append((node_id, label))

            if category_shortcuts:  # Only add categories that have shortcuts
                category_data.append((category, category_shortcuts))

        # Collect "Other" category shortcuts
        other_shortcuts = []
        for section, bindings in self.shortcuts.shortcuts.items():
            for key, value in bindings.items():
                if not any(
                    any(pattern.lower() in key.lower() for pattern in cat.patterns)
                    for cat in SHORTCUT_CATEGORIES
                ):
                    node_id = f"{section}_{key}"
                    label = f"{key}\n{value}"
                    other_shortcuts.append((node_id, label))

        if other_shortcuts:
            category_data.append(
                (
                    ShortcutCategory(name="Other", color="#BFBFBF", patterns=set()),
                    other_shortcuts,
                )
            )

        # Sort categories by size (largest first) for inverted pyramid
        category_data.sort(key=lambda x: len(x[1]), reverse=True)

        # Create subgraphs for each category with grid-like layout
        for category, shortcuts in category_data:
            with dot.subgraph(name=f"cluster_{category.name}") as cluster:
                cluster.attr(
                    label=category.name,
                    style="filled",
                    bgcolor=category.color,
                    fontcolor="white" if category.color != "#FFE119" else "black",
                    fontname=self.config.font_family,
                    margin="15",
                    clusterrank="local",
                )

                # Calculate grid dimensions based on number of shortcuts
                num_shortcuts = len(shortcuts)
                if num_shortcuts > 0:
                    # For LR layout, make wider rows at the top
                    if self.config.rankdir == "LR":
                        # Calculate dimensions to make wider top rows
                        max_cols = int((num_shortcuts**0.5) * 1.5)  # Wider top
                        num_rows = (num_shortcuts + max_cols - 1) // max_cols

                        # Create nodes in grid pattern
                        for i in range(num_rows):
                            with cluster.subgraph() as rank_same:
                                rank_same.attr(rank="same")
                                row_start = i * max_cols
                                row_end = min(row_start + max_cols, num_shortcuts)

                                for j in range(row_start, row_end):
                                    node_id, label = shortcuts[j]
                                    rank_same.node(
                                        node_id,
                                        label,
                                        style="filled",
                                        fillcolor="white",
                                        fontsize="10",
                                    )

                                    # Add invisible edges for grid structure
                                    if j > row_start:
                                        prev_id, _ = shortcuts[j - 1]
                                        dot.edge(prev_id, node_id, style="invis")

                            # Add invisible edges between rows
                            if i > 0:
                                for j in range(row_start, row_end):
                                    if (
                                        j - max_cols >= 0
                                        and j - max_cols < num_shortcuts
                                    ):
                                        curr_id, _ = shortcuts[j]
                                        prev_id, _ = shortcuts[j - max_cols]
                                        dot.edge(prev_id, curr_id, style="invis")
                    else:
                        # Original grid layout for TB direction
                        grid_size = int((num_shortcuts**0.5) + 0.5)
                        for i in range(grid_size):
                            with cluster.subgraph() as rank_same:
                                rank_same.attr(rank="same")
                                for j in range(grid_size):
                                    idx = i * grid_size + j
                                    if idx < num_shortcuts:
                                        node_id, label = shortcuts[idx]
                                        rank_same.node(
                                            node_id,
                                            label,
                                            style="filled",
                                            fillcolor="white",
                                            fontsize="10",
                                        )

        return dot


def create_parser() -> argparse.ArgumentParser:
    """Creates and returns the argument parser for the CLI."""
    parser = argparse.ArgumentParser(
        description="""
        KDE Plasma Keyboard Shortcuts Visualizer

        Creates visual representations of your KDE Plasma keyboard shortcuts from
        .kksrc configuration files. Shortcuts are grouped into categories,
        color-coded, and arranged in a grid-like layout for better organization.
        """
    )

    parser.add_argument(
        "input_file",
        type=str,
        help="Path to the .kksrc file containing keyboard shortcuts",
    )

    parser.add_argument(
        "-o",
        "--output",
        type=str,
        default="kde_shortcuts",
        help="Output file path (without extension)",
    )

    parser.add_argument(
        "--format",
        type=str,
        choices=["svg", "pdf", "png", "jpg"],
        default="png",
        help="Output file format (default: png)",
    )

    parser.add_argument(
        "--dpi", type=str, default="300", help="DPI for PNG output (default: 300)"
    )

    parser.add_argument(
        "--rankdir",
        type=str,
        choices=["LR", "TB"],
        default="TB",
        help="Graph layout direction (LR=left-to-right, TB=top-to-bottom)",
    )

    parser.add_argument(
        "--node-shape",
        type=str,
        default="box",
        help="Shape of the nodes (e.g., box, circle, ellipse)",
    )

    parser.add_argument(
        "--node-style",
        type=str,
        default="rounded",
        help="Style of the nodes (e.g., rounded, filled, dashed)",
    )

    parser.add_argument(
        "--font-family", type=str, default="Arial", help="Font family for text"
    )

    parser.add_argument(
        "--background-color",
        type=str,
        default="lightgrey",
        help="Background color for clusters (name or hex code)",
    )

    parser.add_argument(
        "--verbose", "-v", action="store_true", help="Enable verbose logging output"
    )

    return parser


def main() -> None:
    """Main entry point for the script."""
    parser = create_parser()
    args = parser.parse_args()

    # Set logging level based on verbosity
    if args.verbose:
        logger.setLevel(logging.DEBUG)

    try:
        # Create configuration from command line arguments
        config = VisualizationConfig(
            rankdir=args.rankdir,
            node_shape=args.node_shape,
            node_style=args.node_style,
            font_family=args.font_family,
            background_color=args.background_color,
            output_format=args.format,
            dpi=args.dpi,
        )

        logger.debug("Using configuration: %s", config.model_dump_json(indent=2))

        visualizer = ShortcutVisualizer(args.input_file, config)
        visualizer.generate_visualization(args.output)

    except Exception as e:
        logger.error("Error: %s", str(e))
        sys.exit(1)


if __name__ == "__main__":
    main()
