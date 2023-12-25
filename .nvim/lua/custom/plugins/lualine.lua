return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      theme = "catppuccin",
      component_separators = '',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'undotree', 'diff' },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'quickfix', 'fugitive', 'nvim-tree', 'man', 'toggleterm', 'trouble' },
  },
}
