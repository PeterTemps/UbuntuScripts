#!/bin/bash

sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting curl git

# check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install it first."
    exit 1
fi

# check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install it first."
    exit 1
fi

# check if git is installed
if ! command -v git &> /dev/null; then
    echo "git is not installed. Please install it first."
    exit 1
fi

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
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

# Clone syntax highlighting plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting is already installed."
fi

# Clone autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions is already installed."
fi

# Clone completions plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions"
else
    echo "zsh-completions is already installed."
fi

# Clone fzf plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf" ]; then
    git clone https://github.com/junegunn/fzf.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf"
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf/install" --all
else
    echo "fzf is already installed."
fi

# Clone zsh-z plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z" ]; then
    git clone https://github.com/agkozak/zsh-z.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z"
else
    echo "zsh-z is already installed."
fi

# Clone zsh-interactive-cd plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive-cd" ]; then
    git clone https://github.com/changyuheng/zsh-interactive-cd.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive-cd"
else
    echo "zsh-interactive-cd is already installed."
fi

# clone https://github.com/zdharma-continuum/fast-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
else
    echo "fast-syntax-highlighting is already installed."
fi


# Clone https://github.com/marlonrichert/zsh-autocomplete plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]; then
    git clone https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete"
else
    echo "zsh-autocomplete is already installed."
fi

# Add additional plugins to .zshrc if not already present
# plugins_to_add=("git" "zsh-z" "fzf" "colored-man-pages" "sudo" "history" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-completions")
plugins_to_add=("git" "zsh-z" "fzf" "colored-man-pages" "sudo" "history" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-completions" "zsh-interactive-cd" "fast-syntax-highlighting" "zsh-autocomplete")

for plugin in "${plugins_to_add[@]}"; do
    if ! grep -q "$plugin" ~/.zshrc; then
        sed -i "/^plugins=(/ s/)/ $plugin)/" ~/.zshrc
    fi
done

# Source .zshrc to apply changes
source ~/.zshrc

echo "Plugins installed and configured successfully."

