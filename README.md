# vimcom

Just a simple vim comment plugin made to behave exactly how I want it to. If you want to use this for some reason, you can install it, but keep in mind it is unfinished.

- Uses oneline comments (E.g., `//` for C++, or `#` for Python).
- When multiple lines selected, only nonempty ones are commented/uncommented.
- Commenting respects indentation, so the first character of the comment will have the same indentation as the first character had.
- Doesn't matter if the whole line is selected or only a part of it, the comment is applied the same way.

## Usage

Press Ctrl+/ to comment/uncomment a line in normal/insert mode, or multiple lines selected in visual mode.

## Installation

### Vim

```sh
cd ~/.vim/pack/vimcom
git clone https://github.com/Bleskocvok/vimcom.git
```

### Neovim

```sh
cd ~/.config/nvim/pack
git clone https://github.com/Bleskocvok/vimcom.git
```
