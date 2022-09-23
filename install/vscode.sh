#!/bin/sh

# Copy settings to settings.json
cat $DOTFILES/vscode-settings.json > ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

# Install extentions
for extension in "aaron-bond.better-comments" \
    "ahmadawais.shades-of-purple" \
    "andreaskian.idiomatic-css" \
    "BriteSnow.vscode-toggle-quotes" \
    "dbaeumer.vscode-eslint" \
    "deerawan.vscode-faker" \
    "dsznajder.es7-react-js-snippets" \
    "eamodio.gitlens" \
    "esbenp.prettier-vscode" \
    "GitHub.copilot" \
    "mattpocock.ts-error-translator" \
    "mike-co.import-sorter" \
    "naumovs.color-highlight" \
    "streetsidesoftware.code-spell-checker" \
    "streetsidesoftware.code-spell-checker-danish" \
    "tonybaloney.vscode-pets" \
    "VisualStudioExptTeam.vscodeintellicode" \
    "vivaxy.vscode-conventional-commits" \
    "wix.vscode-import-cost"; do
    code --install-extension "$extension" &> /dev/null
done

echo "Installed VS Code extensions."
