-- Load CSV file from script directory
local tlaplus_plugin_path = vim.fn.expand('<sfile>:p:h')
local csv = vim.fn.readfile(tlaplus_plugin_path .. '/tla-unicode.csv')

-- Discard table header
table.remove(csv, 1)

-- Build up mappings for later use
local mappings = {}
local seen_ascii = {}
for _, line in ipairs(csv) do
  local name, ascii, unicode, _ = unpack(vim.split(line, ','))
  local ascii_variants = vim.split(ascii, ';')
  local description = 'TLA⁺ ' .. name
  for _, ascii_variant in ipairs(ascii_variants) do
    -- There are some duplicate ASCII symbols; discard them
    if (not seen_ascii[ascii_variant]) then
      table.insert(mappings, { description, ascii_variant, unicode })
      seen_ascii[ascii_variant] = true
    end
  end
end

-- These symbols must be interpreted as keywords if using abbreviations
local additional_keywords = {'\\', '>', '<', '=', '.'}

-- Define buffer-local keymaps from mappings computed above
function AddTlaPlusUnicodeMappings()
  -- Don't redefine mappings if they're already defined
  if (not vim.b.tlaplus_mappings_defined) then
    if (vim.g.tlaplus_mappings_use_abbrev) then
      -- Use old vim abbreviations API
      for _, additional_keyword in ipairs(additional_keywords) do
        vim.cmd(string.format('setlocal iskeyword+=%s', additional_keyword))
      end
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
    -- Mark mappings as defined
    vim.b.tlaplus_mappings_use_abbrev = vim.g.tlaplus_mappings_use_abbrev
    vim.b.tlaplus_mappings_defined = true
  end
end

-- Expose add function as command
vim.cmd('command! TlaMappingsAdd lua AddTlaPlusUnicodeMappings()')

-- Check whether disable flag is set before automatically adding mappings
function AutoAddTlaPlusUnicodeMappings()
  if (vim.g.tlaplus_mappings_enable) then
    AddTlaPlusUnicodeMappings()
  end
end

-- Register callback to define mappings when a .tla file is opened
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {'*.tla'},
    callback = AutoAddTlaPlusUnicodeMappings
  }
)

-- Removes buffer-local keymaps if they are defined
function RemoveTlaPlusUnicodeMappings()
  -- Check whether keymaps are actually defined for this buffer
  if (vim.b.tlaplus_mappings_defined) then
    -- Check whether to remove abbreviations or keymaps
    if (vim.b.tlaplus_mappings_use_abbrev) then
      -- Remove abbreviations
      for _, additional_keyword in ipairs(additional_keywords) do
        vim.cmd(string.format('setlocal iskeyword-=%s', additional_keyword))
      end
      for _, mapping in ipairs(mappings) do
        local _, ascii, unicode = unpack(mapping)
        local escaped_ascii = ascii:gsub("|", "\\|")
        vim.cmd(string.format('iunabbrev <buffer> %s', escaped_ascii))
      end
    else
      -- Remove keymaps
      for _, mapping in ipairs(mappings) do
        local _, ascii, _ = unpack(mapping)
        vim.keymap.del('i', ascii, { buffer = true })
      end
    end
    -- Mark keymaps as no longer defined for this buffer
    vim.b.tlaplus_mappings_defined = nil
    vim.b.tlaplus_mappings_use_abbrev = nil
  end
end

-- Expose remove function as command
vim.cmd('command! TlaMappingsRemove lua RemoveTlaPlusUnicodeMappings()')

-- Enable mappings; exposed as command
function EnableTlaPlusUnicodeMappings()
  vim.g.tlaplus_mappings_enable = true
end

vim.cmd('command! TlaMappingsEnable lua EnableTlaPlusUnicodeMappings()')

-- Disable mappings; exposed as command
function DisableTlaPlusUnicodeMappings()
  vim.g.tlaplus_mappings_enable = false
end

vim.cmd('command! TlaMappingsDisable lua DisableTlaPlusUnicodeMappings()')

