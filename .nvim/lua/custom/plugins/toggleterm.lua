return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  version = '*',
  config = function()
    require('toggleterm').setup({
      insert_mappings = false,
      persist_size = false,
      close_on_exit = false,
      direction = 'horizontal',
      float_opts = {
        border = 'rounded',
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 5,
      },
      highlights = {
        FloatBorder = { link = 'TelescopeBorder' },
      },
      size = function(term)
        if term.direction == 'horizontal' then
          return 10
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.3)
        end
      end,
      on_create = function(term)
        local opts = { buffer = term.bufnr }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<cr>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<cr>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<cr>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<cr>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        vim.keymap.set('t', '<C-q>', function()
          vim.cmd.quit({ bang = true })
        end, opts)
      end,
    })
    vim.keymap.set(
      { 'n', 't' },
      '<F1>',
      [[<Cmd>execute 100+v:count "ToggleTerm direction=horizontal"<cr>]]
    )
  end,
}
