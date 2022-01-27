#!/bin/sh

# Copy settings to settings.json
cat $DOTFILES/vscode-settings.json > ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

# Install extentions
for extension in "aaron-bond.better-comments" \
    "naumovs.color-highlight" \
    "streetsidesoftware.code-spell-checker-danish" \
    "streetsidesoftware.code-spell-checker" \
    "vivaxy.vscode-conventional-commits" \
    "joelday.docthis" \
    "dbaeumer.vscode-eslint" \
    "deerawan.vscode-faker" \
    "eamodio.gitlens" \
    "mike-co.import-sorter" \
    "visualstudioexptteam.vscodeintellicode" \
    "wix.vscode-import-cost" \
    "esbenp.prettier-vscode" \
    "tonybaloney.vscode-pets" \
    "dsznajder.es7-react-js-snippets" \
    "ahmadawais.shades-of-purple" \
    "britesnow.vscode-toggle-quotes"; do
    code --install-extension "$extension" &> /dev/null
done

echo "Installed VS Code extensions."

