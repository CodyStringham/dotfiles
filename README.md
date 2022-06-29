# Dotfiles

Living repo of dotfiles and configurations.


## Packages
- FZF: https://github.com/junegunn/fzf
- Bat: https://github.com/sharkdp/bat
- TPM: https://github.com/tmux-plugins/tpm
- Packer: https://github.com/wbthomason/packer.nvim 
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```


## Language Servers
[bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)
[dartls](https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec)
[gopls](https://github.com/golang/tools/tree/master/gopls)
[solargraph](https://solargraph.org/)
[sumneko_lua](https://github.com/sumneko/lua-language-server)
[tsserver](https://github.com/typescript-language-server/typescript-language-server)


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
