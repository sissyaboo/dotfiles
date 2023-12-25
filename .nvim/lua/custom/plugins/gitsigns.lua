return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
