#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Creat symlinks
for i in ".mackup.cfg" \
  ".zshrc" \
  ".gitconfig" \
  ".gitignore"; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/$i"
    rm -rf $targetFile
    ln -fs $sourceFile $targetFile
done

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
source $DOTFILES/.vscode

# Divvy shortcuts
source $DOTFILES/.divvy

# Set macOS preferences
source $DOTFILES/.macos