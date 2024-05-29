# debian_based_general_setup
A start-up script to run on any debian-based OS to so that it is set-up how I like it.

 This script installs everything neccessary for a basic enviornment as I prefer it in Linux
 - GNU Screen
	 * Enables me to use multiple terminals in one terminal.
 - VIM shortcuts in terminal and readline() apps
	* Enables me to use vim shortcuts to navigate the terminal and readline() apps (like iPython)
 - Full version of VIM
	* Default version is normally a slimmed down version - this is the full featured version
	* Pathogen
		- Enables plugins for vim
	* vim-airline
		- Makes vim prettier and easier to navigate
	* vim-rainbow
		- Colour codes opening and closing brackets
	* ALE
		- Syntax checking and semantic errors (ie linting)
	* gruvbox
		- Code text colour coding
	* kite
		- Coding auto-complete suggestions
 - Anaconda
	* Allows quick and easy Python package management

## Applications that require sudo
 * [screenfetch]() is an application that collects system information and displays it in the the terminal in a pretty way.
 * [TerminalTextEffects](https://chrisbuilds.github.io/terminaltexteffects/) is an application that animates stdout in **VERY** cool ways!
     - To see all possible effects see the [showroom](https://chrisbuilds.github.io/terminaltexteffects/showroom/).
