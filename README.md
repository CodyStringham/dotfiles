# Dotfiles

- Tokyonight color scheme
- Monaspace font
- Wezterm terminal
- Neovim editor

## Manual Steps
- Install dependencies
- Download monaspace font
- Create custom nightfox bat theme
- Transfer gitconfig

## Dependencies
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [neovim](https://neovim.io/)
- [zsh](https://ohmyz.sh/)
- [ohmyposh](https://ohmyposh.dev/)
- [monaspace](https://monaspace.githubnext.com/)
- [wezterm](https://github.com/wez/wezterm)
- [delta](https://github.com/dandavison/delta)
- [bat](https://github.com/sharkdp/bat)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [nightfox](https://github.com/EdenEast/nightfox.nvim)

## Usage
```
install all that stuff ^^

ln -s ~/dev/dotfiles/nvim ~/.config/nvim
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
ln -s ~/dev/dotfiles/wezterm.lua ~/.wezterm.lua

now do the stuff below
```

## Delta + Lazygit
You need a combination of the following:
- Add delta configuration to gitconfig
- Configure lazygit to use delta

### Add delta configuration to gitconfig
See gitconfig

### Configure lazygit to use delta
```
nvim ~/Library/Application\ Support/lazygit/config.yml
```

Setup to use delta
```
gui:
  theme:
    lightTheme: false
    selectedLineBgColor:
      - grey
git:
  paging:
    colorArg: always
    pager: delta --paging=never
```
