# neovim-init-file

This is Blaine's neovim init.vim file.
It is current as of September 5, 2021.
It is being used with neovim version 0.6.
It calls some plugins that depend on Lua, so these plugins need to be commented out if using an older version of neovim.
It has been customized to enable the editing of LaTeX files and code files from about a dozen programming languages.
It also has plugins for live previews of the PDF file generated from the LaTeX tex file.

## Script for installing the neovim binary file from the nightly build

I used the following script on September 2, 2021 to install nightly-build neovim 0.6 binaries.

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


