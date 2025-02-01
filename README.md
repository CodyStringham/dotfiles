# Dotfiles

Living repo of dotfiles and configurations.

- Dawnfox theme (so bright)
- Monaspace font with ligatures (so ligatury)
- Wezterm terminal (goodbye tmux)
- Neovim editor (hell yeah)

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

## Delta + Bat + Lazygit
This setup is annoying but worth it. You need a combination of the following:
- Add custom bat theme
- Add delta configuration to gitconfig
- Configure lazygit to use delta

### Add custom Bat theme
```
cd "$(bat --config-dir)/themes"
touch theme.tmTheme
bat cache --build
# Should now be available
bat --list-themes
# Now you can use it in delta config
```

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
    lightTheme: true
    selectedLineBgColor:
      - grey
git:
  paging:
    colorArg: always
    pager: delta --light --paging=never
```
