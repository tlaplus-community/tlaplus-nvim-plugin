# Overview
This is a TLA+ plugin for Neovim (and probably vim, although this is not explicitly supported) which currently does two things:
1. Adds filetype detection for TLA+
2. Translates ASCII TLA+ symbols (like `\leq`, `<=>`, `\A`, etc.) into Unicode as you type

Upon opening a `.tla` file in nvim, a large number of [abbreviations](https://neovim.io/doc/user/map.html#abbreviations) will be defined on the buffer (see the list with `:ab`).
These abbreviations make it so whenever you type an ASCII TLA+ symbol then press space, enter, or tab, the ASCII will be rewritten into its unicode counterpart.
The unicode mappings follow the proposal laid out in https://github.com/tlaplus-community/tlaplus-standard/tree/main/unicode.

The [TLA+ tree-sitter grammar](https://github.com/tlaplus-community/tree-sitter-tlaplus/) is set up to highlight Unicode symbols identically to their ASCII counterparts; to get it, first install & configure the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin then run `:TSInstall tlaplus`.
Unfortunately SANY and TLC do not currently support Unicode symbols, so if you want to fully parse or model-check your spec you'll need to translate it back to ASCII with the [tlaplus-unicode-converter](https://github.com/tlaplus-community/tlaplus-unicode-converter) tool.

## Installation
This plugin can be installed with [vim-plug](https://github.com/junegunn/vim-plug) by putting the following in your `init.vim` file between `plug#begin` and `plug#end`, then running `:PlugInstall`:
```vim
Plug 'tlaplus-community/tlaplus-nvim-plugin'
```

To properly handle Unicode conjunction & disjunction lists, you must use [this fork](https://github.com/tlaplus-community/neovim/releases) of Neovim which is compiled with an [unofficial release](https://github.com/tlaplus-community/tree-sitter/releases/tag/v0.20.1-1) of tree-sitter.
The unofficial tree-sitter release contains fixes [changing the `get_column` API to count codepoints instead of bytes](https://github.com/tree-sitter/tree-sitter/issues/1405), which is important as the conjunction & disjunction list parsing code relies heavily on `get_column` to determine vertical alignment.
Unicode codepoints are often multiple bytes in size, so a byte-based `get_column` function will often not work exactly right.
This feature will hopefully get merged and upstreamed by the end of 2021.
