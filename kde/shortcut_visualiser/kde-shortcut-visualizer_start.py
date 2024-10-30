#!/usr/bin/env python3
"""KDE Plasma keyboard shortcuts visualization tool with categorical grouping and inverted pyramid layout."""

# [Previous imports remain the same...]

class ShortcutVisualizer:
    """A class to visualize KDE Plasma keyboard shortcuts."""
    
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
                    if any(pattern.lower() in key.lower() for pattern in category.patterns):
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
            category_data.append((
                ShortcutCategory(
                    name="Other",
                    color="#BFBFBF",
                    patterns=set()
                ),
                other_shortcuts
            ))

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
                        max_cols = int((num_shortcuts ** 0.5) * 1.5)  # Wider top
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
                                    if j - max_cols >= 0 and j - max_cols < num_shortcuts:
                                        curr_id, _ = shortcuts[j]
                                        prev_id, _ = shortcuts[j - max_cols]
                                        dot.edge(prev_id, curr_id, style="invis")
                    else:
                        # Original grid layout for TB direction
                        grid_size = int((num_shortcuts ** 0.5) + 0.5)
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

# [Rest of the code remains unchanged...]
