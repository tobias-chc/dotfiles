# Dotfiles

This repository contains my system dotfiles.

## System Specifications

- **Model**: MacBook Air
- **Chip**: Apple M3
- **Memory**: 8GB
- **macOS**: Sequoia 15.6.1

## Requirements

You'll need [stow](https://www.gnu.org/software/stow/) installed on your system.

```sh
brew install stow
```

Since the `zsh` configuration files are located outside the `$HOME` directory, add the following line to `/etc/zshenv`:

```sh
export ZDOTDIR="$HOME/.config/zsh"
```

You can do this by running:

```sh
echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee /etc/zshenv
```

## Installation

1. Clone the dotfiles repository to your home directory:

```sh
git clone git@github.com:tobias-chc/dotfiles.git
cd dotfiles
```

2. Create symlinks using GNU stow:

```sh
stow .
```
