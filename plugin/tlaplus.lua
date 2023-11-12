local plugin_path = vim.fn.expand('<sfile>:p:h')

function AddTlaPlusUnicodeMappings()
  -- Read TLA⁺ unicode CSV file
  local csv = vim.fn.readfile(plugin_path .. '/tla-unicode.csv')

  -- Remove table header
  table.remove(csv, 1)

  -- Iterate over unicode mapping table and construct abbreviations
  for _, line in ipairs(csv) do
    local name, ascii, unicode, _ = unpack(vim.split(line, ','))
    local ascii_variants = vim.split(ascii, ';')
    for _, ascii_variant in ipairs(ascii_variants) do
      local description = 'TLA⁺ ' .. name
      vim.keymap.set('i', ascii_variant, unicode, { desc = description, buffer = true })
    end
  end
end

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {'*.tla'},
    callback = AddTlaPlusUnicodeMappings
  }
)

