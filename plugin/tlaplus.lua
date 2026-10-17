-- Symbol definitions: name, ASCII aliases, Unicode, and optional input preference.
-- Abbreviations protect symbols that commonly prefix longer ASCII tokens.
-- Symbols with duplicate ASCII/Unicode mappings have been removed.
local symbols = {
  { 'def_eq', { '==' }, '≜', abbrev = true },
  { 'set_in', { '\\in' }, '∈' },
  { 'gets', { '<-' }, '←' },
  { 'forall', { '\\A', '\\forall' }, '∀' },
  { 'exists', { '\\E', '\\exists' }, '∃' },
  { 'all_map_to', { '|->' }, '↦' },
  { 'maps_to', { '->' }, '→' },
  { 'langle_bracket', { '<<' }, '⟨' },
  { 'rangle_bracket', { '>>' }, '⟩' },
  { 'rangle_bracket_sub', { '>>_' }, '⟩_' },
  { 'case_box', { '[]' }, '□' },
  { 'label_as', { '::' }, '∷' },
  { 'lnot', { '~', '\\lnot', '\\neg' }, '¬' },
  { 'eventually', { '<>' }, '◇' },
  { 'implies', { '=>' }, '⇒' },
  { 'plus_arrow', { '-+->' }, '⇸' },
  { 'equiv', { '\\equiv' }, '≡' },
  { 'iff', { '<=>' }, '⇔' },
  { 'leads_to', { '~>' }, '↝' },
  { 'land', { '/\\', '\\land' }, '∧' },
  { 'lor', { '\\/', '\\lor' }, '∨' },
  { 'assign', { ':=' }, '≔' },
  { 'bnf_rule', { '::=' }, '⩴' },
  { 'neq', { '/=', '#' }, '≠' },
  { 'leq', { '<=', '=<', '\\leq' }, '≤' },
  { 'geq', { '>=', '\\geq' }, '≥' },
  { 'approx', { '\\approx' }, '≈' },
  { 'rs_ttile', { '|-' }, '⊢' },
  { 'rd_ttile', { '|=' }, '⊨' },
  { 'ls_ttile', { '-|' }, '⊣' },
  { 'ld_ttile', { '=|' }, '⫤' },
  { 'asymp', { '\\asymp' }, '≍' },
  { 'cong', { '\\cong' }, '≅' },
  { 'doteq', { '\\doteq' }, '≐' },
  { 'gg', { '\\gg' }, '≫' },
  { 'll', { '\\ll' }, '≪' },
  { 'notin', { '\\notin' }, '∉' },
  { 'prec', { '\\prec' }, '≺' },
  { 'succ', { '\\succ' }, '≻' },
  { 'preceq', { '\\preceq' }, '⪯' },
  { 'succeq', { '\\succeq' }, '⪰' },
  { 'propto', { '\\propto' }, '∝' },
  { 'sim', { '\\sim' }, '∼' },
  { 'simeq', { '\\simeq' }, '≃' },
  { 'sqsubset', { '\\sqsubset' }, '⊏' },
  { 'sqsupset', { '\\sqsupset' }, '⊐' },
  { 'sqsubseteq', { '\\sqsubseteq' }, '⊑' },
  { 'sqsupseteq', { '\\sqsupseteq' }, '⊒' },
  { 'subset', { '\\subset' }, '⊂' },
  { 'supset', { '\\supset' }, '⊃' },
  { 'subseteq', { '\\subseteq' }, '⊆' },
  { 'supseteq', { '\\supseteq' }, '⊇' },
  { 'cap', { '\\intersect', '\\cap' }, '∩' },
  { 'cup', { '\\union', '\\cup' }, '∪' },
  { 'dots_2', { '..' }, '‥' },
  { 'dots_3', { '...' }, '…' },
  { 'oplus', { '(+)', '\\oplus' }, '⊕' },
  { 'ominus', { '(-)', '\\ominus' }, '⊖' },
  { 'vertvert', { '||' }, '‖' },
  { 'odot', { '(.)', '\\odot' }, '⊙' },
  { 'oslash', { '(/)', '\\oslash' }, '⊘' },
  { 'otimes', { '(\\X)', '\\otimes' }, '⊗' },
  { 'bigcirc', { '\\bigcirc' }, '◯' },
  { 'bullet', { '\\bullet' }, '●' },
  { 'div', { '\\div' }, '÷' },
  { 'circ', { '\\o', '\\circ' }, '∘' },
  { 'star', { '\\star' }, '⋆' },
  { 'excl', { '!!' }, '‼' },
  { 'qq', { '??' }, '⁇' },
  { 'sqcap', { '\\sqcap' }, '⊓' },
  { 'sqcup', { '\\sqcup' }, '⊔' },
  { 'uplus', { '\\uplus' }, '⊎' },
  { 'times', { '\\X', '\\times' }, '×' },
  { 'wr', { '\\wr' }, '≀' },
  { 'cdot', { '\\cdot' }, '⋅' },
  { 'sup_plus', { '^+' }, '⁺' },
  { 'nat_number_set', { 'Nat' }, 'ℕ', abbrev = true },
  { 'int_number_set', { 'Int' }, 'ℤ', abbrev = true },
  { 'real_number_set', { 'Real' }, 'ℝ', abbrev = true },
}

-- Build up mappings for later use
local mappings = {}
for _, symbol in ipairs(symbols) do
  local name, ascii_variants, unicode = unpack(symbol)
  local description = 'TLA⁺ ' .. name
  for _, ascii_variant in ipairs(ascii_variants) do
    table.insert(mappings, { description, ascii_variant, unicode, abbrev = symbol.abbrev })
  end
end

-- These symbols must be interpreted as keywords if using abbreviations
local additional_keywords = {'\\', '>', '<', '=', '.'}

-- Define buffer-local keymaps from mappings computed above
local function AddTlaPlusUnicodeMappings()
  -- Don't redefine mappings if they're already defined
  if vim.b.tlaplus_mappings_defined then return end

  -- Treat runs of equals signs as one word, preserving module terminators.
  local keywords = vim.g.tlaplus_mappings_use_abbrev and additional_keywords or { '=' }
  local existing = vim.opt_local.iskeyword:get()
  local added = {}
  for _, keyword in ipairs(keywords) do
    if not vim.tbl_contains(existing, keyword) then
      table.insert(added, keyword)
    end
  end
  -- Track only our additions so removal preserves other keyword changes.
  vim.opt_local.iskeyword:append(added)
  vim.b.tlaplus_added_keywords = added
  for _, mapping in ipairs(mappings) do
    local description, ascii, unicode = unpack(mapping)
    local mode = (vim.g.tlaplus_mappings_use_abbrev or mapping.abbrev) and 'ia' or 'i'
    vim.keymap.set(mode, ascii, unicode, { desc = description, buffer = true })
  end
  -- Mark mappings as defined
  vim.b.tlaplus_mappings_use_abbrev = vim.g.tlaplus_mappings_use_abbrev
  vim.b.tlaplus_mappings_defined = true
end

-- Expose add function as command
vim.api.nvim_create_user_command('TlaMappingsAdd', AddTlaPlusUnicodeMappings, {})

-- Check whether disable flag is set before automatically adding mappings
local function AutoAddTlaPlusUnicodeMappings()
  if (vim.g.tlaplus_mappings_enable) then
    AddTlaPlusUnicodeMappings()
  end
end

-- Register callback to define mappings when a .tla file is opened
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group = vim.api.nvim_create_augroup('TlaPlusUnicodeMappings', { clear = true }),
    pattern = {'*.tla'},
    callback = AutoAddTlaPlusUnicodeMappings
  }
)

-- Removes buffer-local keymaps if they are defined
local function RemoveTlaPlusUnicodeMappings()
  -- Check whether keymaps are actually defined for this buffer
  if not vim.b.tlaplus_mappings_defined then return end

  for _, mapping in ipairs(mappings) do
    local _, ascii = unpack(mapping)
    local mode = (vim.b.tlaplus_mappings_use_abbrev or mapping.abbrev) and 'ia' or 'i'
    vim.keymap.del(mode, ascii, { buffer = true })
  end
  vim.opt_local.iskeyword:remove(vim.b.tlaplus_added_keywords)
  vim.b.tlaplus_added_keywords = nil
  -- Mark keymaps as no longer defined for this buffer
  vim.b.tlaplus_mappings_defined = nil
  vim.b.tlaplus_mappings_use_abbrev = nil
end

-- Expose remove function as command
vim.api.nvim_create_user_command('TlaMappingsRemove', RemoveTlaPlusUnicodeMappings, {})

-- Enable mappings; exposed as command
local function EnableTlaPlusUnicodeMappings()
  vim.g.tlaplus_mappings_enable = true
end

vim.api.nvim_create_user_command('TlaMappingsEnable', EnableTlaPlusUnicodeMappings, {})

-- Disable mappings; exposed as command
local function DisableTlaPlusUnicodeMappings()
  vim.g.tlaplus_mappings_enable = false
end

vim.api.nvim_create_user_command('TlaMappingsDisable', DisableTlaPlusUnicodeMappings, {})
