return {
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    'vim-test/vim-test',
    config = function()
      vim.cmd [[
        function! BufferTermStrategy(cmd)
          exec 'te ' . a:cmd
        endfunction
        let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
        let g:test#strategy = 'bufferterm'
      ]]
    end,
    keys = {
      {
        '<leader>Tf',
        '<cmd>TestFile<cr>',
        silent = true,
        desc = 'Run this file',
      },
      {
        '<leader>Tn',
        '<cmd>TestNearest<cr>',
        silent = true,
        desc = 'Run nearest test',
      },
      {
        '<leader>Tl',
        '<cmd>TestLast<cr>',
        silent = true,
        desc = 'Run last test',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = {
            min = 30,
            max = 50,
          },
          side = 'left',
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        elixir = { 'credo' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', {
        clear = true,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
      vim.api.nvim_set_hl(0, 'Normal', { ctermbg = nil, bg = nil })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier', 'eslint_d' },
        typescript = { 'prettier', 'eslint_d' },
        ruby = { 'rubocop' },
        elixir = { 'credo' },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'dcampos/cmp-emmet-vim',
    dependencies = { 'mattn/emmet-vim' },
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {

        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            {
              desc = '󰊳 Update',
              group = '@property',
              action = 'Lazy update',
              key = 'u',
            },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
}
