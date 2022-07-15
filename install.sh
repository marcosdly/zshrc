#! /usr/bin/env bash

# Checking for git's existence
if [[ $(command -v git) ]]; then
	echo ":: Found git"
else
	echo "ERROR: git not found"
	echo "exiting..."
	exit 1
fi

# Current script's directory
DIR=$(dirname "$BASH_SOURCE")

# Checking if file exists
echo ":: Copying .zshrc to home"
if [[ -f "$HOME/.zshrc" ]]; then
	# Asking if user wants to overwrite
	read -p "?? File ~/.zshrc already exists, overwrite? (y/N) "  ZSHRC_ANSWER
	if [[ "$ZSHRC_ANSWER" == "y" || "$ZSHRC_ANSWER" == "Y" ]]; then
		echo ":: Overwriting ~/.zshrc file"
		cp "$DIR/.zshrc" "$HOME"
		echo ":: Done"
	else
		echo ":: Skipping .zshrc"
	fi
else
	# Copying file
	cp "$DIR/.zshrc" "$HOME"
	echo ":: Done"
fi

# Cloning plugin's repos
echo ":: Cloning plugins"
git submodule update --init --recursive --depth "1"
echo ":: Done"

# Checking if directory exists
echo ":: Copying plugins"
if [[ -d "$HOME/.zplugins" ]]; then
	# Asking if user wants to overwrite
	read -p "?? Directory ~/.zplugins already exists, overwrite? (y/N) " PLUGINS_ANSWER
	if [[ "$PLUGINS_ANSWER" == "y" || "$PLUGINS_ANSWER" == "Y" ]]; then
		echo ":: Overwriting ~/.zplugins directory"
		cp -r "$DIR/.zplugins/" "$HOME"
		echo ":: Done"
	else
		echo ":: Skipping .zplugins"
	fi
else
	# Copying directory
	cp -r "$DIR/.zplugins/" "$HOME"
	echo ":: Done"
fi

# Asking if user wants to ser zsh as default
read -p "?? Set zsh to default shell? (y/N) " SHELL_ANSWER

if [[ "$SHELL_ANSWER" == "y" || "$SHELL_ANSWER" == "Y" ]]; then
	sudo usermod -s $(cat "/etc/shells" | grep "zsh" | tail -n 1) "$USER"
	echo ":: Zsh set as default shell"
	echo ":: Done!"
	exit 0
else
	echo ":: Done!"
	exit 0
fi

