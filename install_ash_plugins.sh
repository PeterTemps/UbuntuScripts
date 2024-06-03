#!/bin/bash

# Function to install Oh My Zsh if not already installed
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh is already installed."
    fi
}

# Install Oh My Zsh
install_oh_my_zsh

# Set Zsh as the default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

# Clone syntax highlighting plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting is already installed."
fi

# Clone autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions is already installed."
fi

# Clone completions plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
else
    echo "zsh-completions is already installed."
fi

# Clone fzf plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf" ]; then
    git clone https://github.com/junegunn/fzf.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf/install --all
else
    echo "fzf is already installed."
fi

# Add additional plugins to .zshrc if not already present
plugins_to_add=("git" "z" "fzf" "colored-man-pages" "sudo" "history" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-completions")

for plugin in "${plugins_to_add[@]}"; do
    if ! grep -q "$plugin" ~/.zshrc; then
        sed -i "/^plugins=(/ s/)/ $plugin)/" ~/.zshrc
    fi
done

# Source .zshrc to apply changes
source ~/.zshrc

echo "Plugins installed and configured successfully."

