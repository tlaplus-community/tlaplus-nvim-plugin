This is a TLA⁺ plugin for Neovim that translates ASCII TLA⁺ symbols into Unicode as you type.
It translates `\leq` into `≤`, `<=>` into `⇔`, `\A` into `∀`, and so on.
Watch [the asciinema demo](https://asciinema.org/a/620647)!

![](demos/keymap.gif)

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

## Configuration & Commands

To define mappings automatically whenever you open a `.tla` file, set the global `tlaplus_mappings_enable` variable in your `init.vim`:
```vim
let g:tlaplus_mappings_enable = 1
```
or your `init.lua`:
```lua
vim.g.tlaplus_mappings_enabled = true
```
You can remove the mappings from a buffer with the `TlaMappingsRemove` command.
Alternatively, if you keep the `tlaplus_mappings_enabled` variable undefined or `false`, you can selectively add the mappings to a buffer with the `TlaMappingsAdd` command.

For convenience you can also enable or disable the plugin for the duration of your editing session with the `TlaMappingsEnable` and `TlaMappingsDisable` commands respectively.
Note that these commands will not add nor remove mappings from any open buffers, and only affect the auto-loading functionality when a `.tla` file is opened.
To add or remove mappings from open buffers use the `TlaMappingsAdd` and `TlaMappingsRemove` commands as described above.

This plugin also exposes the global configuration variable `tlaplus_mappings_use_abbrev`.
Setting this variable makes the plugin use the older vim [abbreviations API](https://neovim.io/doc/user/map.html#abbreviation) instead of the newer neovim keymap API.
This provides a somewhat different editing experience - try both and see which one you like!

## Other TLA⁺ Plugins

- [florentc/vim-tla](https://github.com/florentc/vim-tla) uses text concealing instead of changing the actual text
- [susliko/tla.nvim](https://github.com/susliko/tla.nvim) interfaces with the Java TLA⁺ tools

