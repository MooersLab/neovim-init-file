# neovim-init-file

This is Blaine's neovim init.vim file.
It is current as of September 5, 2021.
It is being used with neovim version 0.6.

The Vim-Plug plugin manager is used.
Update the plugins with the command `:PlugUpdate`.

The init.vim calls some plugins that depend on Lua, which became incorporated in neovim 0.5, so these plugins need to be commented out if using neovim < 0.5.
The init.vim file has been customized to enable the editing of LaTeX files and code files from about a dozen programming languages.
It also has plugins for live previews of the PDF file generated from the LaTeX tex file.
The init.vim file also invokes LSP servers for autocompletion.


## Script for installing the neovim binary file from the nightly build on Mac OS

I used the following script on September 2, 2021 to install nightly-build neovim 0.6 binary.

```bash
#!/bin/zsh

# Change the above to your shell.
# This script enables the quick install of the nighlty release of neovim. 
# source:  https://www.reddit.com/r/neovim/comments/j38ook/neovim_050_on_mac/
# Note: you may need to make a ~/dev/nvim-osx64 directory first.

echo "Download..."
cd ~/Downloads
rm -vrf nvim-macos.tar.gz
curl -# -L -O https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar zxpvf nvim-macos.tar.gz

cd ~/dev/nvim-osx64

echo "Installing..."
rm -vrf ~/dev/nvim-osx64/bin
rm -vrf ~/dev/nvim-osx64/share
rm -vrf ~/dev/nvim-osx64/lib
rm -vrf ~/dev/nvim-osx64/libs
mv ~/Downloads/nvim-osx64/bin .
mv ~/Downloads/nvim-osx64/share .
mv ~/Downloads/nvim-osx64/lib .
mv ~/Downloads/nvim-osx64/libs .

echo "Removing downloaded dir..."
rmdir ~/Downloads/nvim-osx64

rm -vrf ~/Downloads/nvim-macos.tar.gz

echo "The End!"
```

## Links of interest

* [Telescope fuzzy finder](https://github.com/nvim-telescope/telescope.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* [tree-sitter](https://github.com/tree-sitter/tree-sitter)
* [Neovim plugin to open multiple files in one buffer](https://pythonawesome.com/neovim-plugin-to-open-multiple-files-in-one-buffer/) 


## Books on neovim

* 	***Modern Vim: Craft Your Development Environment with Vim 8 and Neovim*** (2018) by Neil Drew




