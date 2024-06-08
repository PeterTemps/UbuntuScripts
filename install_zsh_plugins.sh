#!/bin/bash

apt install zsh git curl wget zsh-autosuggestions zsh-syntax-highlighting zsh-completions -y

# check if zsh is installed
if ! dpkg -l | grep -q zsh; then
    echo "Zsh is not installed. Please install it first."
    exit 1
fi

# check if curl is installed
if ! dpkg -l | grep -q curl; then
    echo "curl is not installed. Please install it first."
    exit 1
fi

# check if git is installed
if ! dpkg -l | grep -q git; then
    echo "git is not installed. Please install it first."
    exit 1
fi

# define MY_OH_MY_ZSH variable to store the path to the Oh My Zsh installation directory
MY_OH_MY_ZSH="$HOME/.oh-my-zsh"
echo "MY_OH_MY_ZSH: $MY_OH_MY_ZSH"

#sleep for 4 seconds
sleep 4

# install Oh My Zsh if not already installed

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exit 0
else
    echo "Oh My Zsh is already installed."
fi




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

# Clone zsh-z plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z" ]; then
    git clone https://github.com/agkozak/zsh-z.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
else
    echo "zsh-z is already installed."
fi

# Clone zsh-interactive-cd plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive-cd" ]; then
    git clone https://github.com/changyuheng/zsh-interactive-cd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive-cd
else
    echo "zsh-interactive-cd is already installed."
fi

# clone https://github.com/zdharma-continuum/fast-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
else
    echo "fast-syntax-highlighting is already installed."
fi


# Clone https://github.com/marlonrichert/zsh-autocomplete plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]; then
    git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
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

# set user default shell to zsh
chsh -s $(which zsh)

# Source .zshrc to apply changes
source ~/.zshrc

echo "Plugins installed and configured successfully."

