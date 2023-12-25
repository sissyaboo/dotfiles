return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  main = "ibl",
  opts = {
    indent = {
      char = "▏"
    },
    scope = {
      enabled = false,
    },
    exclude = {
      filetypes = {
        'log',
        'fugitive',
        'markdown',
        'txt',
        'NvimTree',
        'git',
        'undotree',
        '',
      }
    },
  },
}
