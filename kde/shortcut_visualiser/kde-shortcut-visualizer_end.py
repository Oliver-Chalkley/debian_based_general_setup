[Previous code remains the same until parser.add_argument('--background-color')]

    parser.add_argument(
        '--background-color',
        type=str,
        default='lightgrey',
        help='Background color for clusters (name or hex code)'
    )

    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Enable verbose logging output'
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
            dpi=args.dpi
        )
        
        logger.debug("Using configuration: %s", config.model_dump_json(indent=2))
        
        visualizer = ShortcutVisualizer(args.input_file, config)
        visualizer.generate_visualization(args.output)
        
    except Exception as e:
        logger.error("Error: %s", str(e))
        sys.exit(1)

if __name__ == "__main__":
    main()
