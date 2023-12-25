return {
  'akinsho/bufferline.nvim',
  lazy = true,
  after = "catppuccin",
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  version = 'v3.*',
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      separator_style = 'thin',
      indicator = {
        style = 'none',
      },
      offsets = {
        { filetype = 'NvimTree', text = 'File Explorer', text_align = 'center' },
        { filetype = 'undotree', text = 'Undo Tree',     text_align = 'center' },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    vim.keymap.set('n', 'H', '<Cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', 'L', '<Cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })
  end,
}
