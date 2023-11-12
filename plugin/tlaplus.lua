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
  for _, mapping in ipairs(mappings) do
    local description, ascii, unicode = unpack(mapping)
    vim.keymap.set('i', ascii, unicode, { desc = description, buffer = true })
  end
end

-- Register callback to define mappings when a .tla file is entered
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {'*.tla'},
    callback = AddTlaPlusUnicodeMappings
  }
)

