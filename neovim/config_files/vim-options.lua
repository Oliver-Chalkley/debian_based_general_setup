vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

local opts = { noremap = true, silent = true }

-- Lspsaga key mappings
vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)      -- Go to definition
vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opts)          -- Find references and definitions
vim.keymap.set('n', 'gi', '<cmd>Lspsaga goto_implementation<CR>', opts) -- Go to implementation
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)            -- Hover documentation
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)      -- Rename symbol
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts) -- Code action
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts) -- Previous diagnostic
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts) -- Next diagnostic

-- Avante
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
