return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    keys = {
      { '<c-p>',     '<Cmd>Telescope find_files<cr>' },
      { '<leader>d', '<Cmd>Telescope oldfiles<cr>' },
      { '<leader>m', '<Cmd>Telescope man_pages<cr>' },
      { '<leader>b', '<Cmd>Telescope buffers<cr>' },
      { '<leader>h', '<Cmd>Telescope help_tags<cr>' },
      { '<leader>g', '<Cmd>Telescope live_grep<cr>' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-ui-select.nvim',
        lazy = true,
        config = function()
          require('telescope').load_extension('ui-select')
        end,
      },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.9,
            height = 0.9,
            horizontal = {
              preview_width = 0.6,
            },
          },
          mappings = {
            i = {
              ['<esc>'] = require('telescope.actions').close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--ignore',
              '-u',
              '--glob=!**/.git/*',
              '--glob=!**/node_modules/*',
              '--glob=!**/.next/*',
              '--glob=!**/.DS_Store*',
            },
          },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
}
