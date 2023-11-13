-- Load CSV file from script directory
local tlaplus_plugin_path = vim.fn.expand('<sfile>:p:h')
local csv = vim.fn.readfile(tlaplus_plugin_path .. '/tla-unicode.csv')

-- Discard table header
table.remove(csv, 1)

-- Build up mappings for later use
local mappings = {}
for _, line in ipairs(csv) do
  local name, ascii, unicode, _ = unpack(vim.split(line, ','))
  local ascii_variants = vim.split(ascii, ';')
  local description = 'TLA⁺ ' .. name
  for _, ascii_variant in ipairs(ascii_variants) do
    table.insert(mappings, { description, ascii_variant, unicode })
  end
end

-- Define buffer-local keymaps from mappings computed above
function AddTlaPlusUnicodeMappings()
  if (vim.g.tlaplus_use_abbrev) then
    -- Use old vim abbreviations API
    vim.cmd('setlocal iskeyword+=\\')
    vim.cmd('setlocal iskeyword+=>')
    vim.cmd('setlocal iskeyword+=<')
    vim.cmd('setlocal iskeyword+==')
    vim.cmd('setlocal iskeyword+=.')
    for _, mapping in ipairs(mappings) do
      local _, ascii, unicode = unpack(mapping)
      local escaped_ascii = ascii:gsub("|", "\\|")
      vim.cmd(string.format('inoreabbrev <buffer> %s %s', escaped_ascii, unicode))
    end
  else
    -- Use new neovim keymap API
    for _, mapping in ipairs(mappings) do
      local description, ascii, unicode = unpack(mapping)
      vim.keymap.set('i', ascii, unicode, { desc = description, buffer = true })
    end
  end
end

-- Register callback to define mappings when a .tla file is opened
vim.api.nvim_create_autocmd({"BufRead"}, {
    pattern = {'*.tla'},
    callback = AddTlaPlusUnicodeMappings
  }
)

