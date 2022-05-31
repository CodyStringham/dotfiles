# Dotfiles

Living repo of dotfiles and configurations.

## Packages
- Packer: https://github.com/wbthomason/packer.nvim 
- FZF: https://github.com/junegunn/fzf
- Bat: https://github.com/sharkdp/bat
- TPM: https://github.com/tmux-plugins/tpm
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```


## Usage
```
ln -s ~/dev/dotfiles/nvim ~/.config/nvim
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
ln -s ~/dev/dotfiles/alacritty.yml ~/.alacritty.yml
```

## Tmux config
```
tic -x tmux.terminfo
```
