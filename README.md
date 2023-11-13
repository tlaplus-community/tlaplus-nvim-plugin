# Overview
This is a TLA⁺ plugin for Neovim that translates ASCII TLA⁺ symbols into Unicode as you type.
It translates `\leq` into `≤`, `<=>` into `⇔`, `\A` into `∀`, and so on.
Watch [the asciinema demo](https://asciinema.org/a/620647)!

![](demo.gif)

Upon opening a `.tla` file in nvim, around 80 different [key mappings](https://neovim.io/doc/user/lua.html#vim.keymap) will be defined for the buffer.
These mappings make it so whenever you type an ASCII TLA+ symbol, the ASCII will be replaced by its Unicode counterpart.
The Unicode mappings follow the standardization proposal laid out [here](https://github.com/tlaplus/tlaplus-standard/tree/main/unicode).

The [TLA+ tree-sitter grammar](https://github.com/tlaplus-community/tree-sitter-tlaplus/) is set up to highlight Unicode symbols identically to their ASCII counterparts.
It pairs very nicely with this plugin; to get it, first install & configure [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) then run `:TSInstall tlaplus`.

Unfortunately SANY and TLC do not currently support Unicode symbols, so if you want to fully parse or model-check your spec you'll need to translate it back to ASCII with the [TLAUC](https://github.com/tlaplus-community/tlauc) command-line tool.

## Installation
This plugin can be installed with [vim-plug](https://github.com/junegunn/vim-plug) by putting the following in your `init.vim` file between `plug#begin` and `plug#end`, then running `:PlugInstall`:
```vim
Plug 'tlaplus-community/tlaplus-nvim-plugin'
```
Since this plugin is just a single Lua file it can likely be installed similarly easily by any other nvim package manager.

