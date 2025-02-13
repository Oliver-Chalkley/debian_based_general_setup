return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  { 'neovim/nvim-lspconfig' },        -- Core LSP
  { 'hrsh7th/nvim-cmp' },             -- Autocompletion
  { 'hrsh7th/cmp-nvim-lsp' },         -- LSP source for completion
  { 'L3MON4D3/LuaSnip' },             -- Snippet support
  { 'jose-elias-alvarez/null-ls.nvim' }, -- Formatting & linting
  { 'glepnir/lspsaga.nvim' },         -- UI enhancements
  { 'nvim-treesitter/nvim-treesitter' }, -- Treesitter for better syntax
  {
  'onsails/lspkind.nvim'
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = true, -- Show the current function/method in the winbar
        },
      })
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' }, -- For icons
      { 'nvim-treesitter/nvim-treesitter' } -- For better syntax highlighting
    }
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
