#!/bin/sh

echo "Setting up your Mac..."

# Install Homebrew or make sure it's up to date
which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
  brew upgrade
fi

# Creat symlinks using Stow
which -s stow
if [[ $? != 0 ]] ; then
  brew install stow
  stow .
fi

# Reload .zshrc to make `$DOTFILES` alias available
source ~/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Create a Sites directory
mkdir $HOME/Sites

# Remove outdated versions from the cellar.
brew cleanup

# VS Code preferences
source $DOTFILES/install/vscode.sh

# Set macOS preferences
source $DOTFILES/macos/dock.sh
source $DOTFILES/macos/defaults.sh