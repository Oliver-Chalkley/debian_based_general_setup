-- Install lazy vim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load vim options from vim-options.lua
require("vim-options")
-- load plugins
require("lazy").setup("plugins")

-- Set plugins up
-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>fz', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- Set colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
-- Treesitter
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "c", "cpp", "diff", "dockerfile", "dot", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "jq", "json", "json5", "make", "markdown", "r", "regex", "sql", "ssh_config", "terraform", "toml", "xml", "yaml", "lua", "vim", "vimdoc", "python", "elixir", "heex", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
})
-- Autocomplete
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP suggestions
    { name = 'luasnip' },
    { name = 'buffer' },   -- Buffer words
    { name = 'path' },     -- File paths
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
  }
})
-- Pyright
require('lspconfig').pyright.setup{}
-- LSP Saga
require('lspsaga').setup({
  ui = {
    border = 'rounded', -- Rounded borders for popups
  },
  lightbulb = {
    enable = true, -- Show a lightbulb when a code action is available
  },
  diagnostic = {
    show_source = true,
  },
})
