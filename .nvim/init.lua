vim.o.splitright = true
vim.o.splitbelow = true

vim.o.termguicolors = true

vim.o.mouse = 'a'
vim.o.fileformats = 'unix,mac,dos'
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.autowrite = true
vim.o.report = 0
vim.o.history = 500

vim.o.wrap = false

vim.o.cmdheight = 2
vim.o.showcmd = false
vim.o.showmatch = true
vim.opt.shortmess:append('acI')

vim.o.complete = '.,w,b,u,i,]'
vim.o.completeopt = 'longest,menuone,noselect'

vim.o.pumheight = 15

vim.o.wildmode = 'list:longest,full'
vim.opt.wildignore:append('*/node_modules/*')
vim.opt.wildignore:append('*/git/*')

vim.o.ttimeout = true
vim.o.ttimeoutlen = 1
vim.o.timeoutlen = 400
vim.o.scrolloff = 999
vim.o.scrolljump = -5

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.linebreak = true
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.preserveindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true

vim.o.swapfile = false
vim.o.undofile = true

vim.o.updatetime = 50
vim.wo.signcolumn = 'yes'
vim.o.cursorline = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('custom.plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'editorconfig',
        'tarPlugin',
        'netrwPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

local configs = 'nvim_utils'
vim.api.nvim_create_augroup(configs, { clear = true })

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end
  vim.cmd.cd(data.file)
  require('nvim-tree.api').tree.open()
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = configs,
  callback = open_nvim_tree,
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = configs,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
  group = configs,
  pattern = { '*.txt', '*.md', 'text' },
  command = 'setlocal spell | setlocal cc=80',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = configs,
  pattern = { 'gitcommit' },
  command = 'setlocal spell | setlocal cc=51',
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = configs,
  pattern = { '*.ts,*.js,*.jsx,*.tsx' },
  command = 'EslintFixAll',
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'InsertEnter' }, {
  group = configs,
  command = 'set nocursorline',
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave' }, {
  group = configs,
  command = 'set cursorline',
})

vim.api.nvim_create_autocmd('FileType', {
  group = configs,
  pattern = { 'help', 'man', 'fugitive' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<Cmd>quit<cr>', { silent = true, buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = configs,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- https://github.com/neovim/neovim/issues/16339#issuecomment-1348133829
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
  group = configs,
  callback = function()
    local ignore_buftype = { 'quickfix', 'nofile', 'help', 'terminal', 'toggleterm', 'trouble' }
    local ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }

    if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
      return
    end

    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      vim.cmd([[normal! gg]])
      return
    end

    if vim.fn.line('.') > 1 then
      return
    end

    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line('$')

    if last_line > 0 and last_line <= buff_last_line then
      local win_last_line = vim.fn.line('w$')
      local win_first_line = vim.fn.line('w0')
      if win_last_line == buff_last_line then
        vim.cmd([[normal! g`"]])
      elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
        vim.cmd([[normal! g`"zz]])
      else
        vim.cmd([[normal! G'"<c-e>]])
      end
    end
  end,
})

vim.api.nvim_create_user_command('CWKB', function()
  local bufnr = vim.fn.bufnr()
  local wins = vim.fn.getbufinfo({ bufnr = bufnr })[1].windows

  if #wins > 1 then
    vim.cmd('close')
  else
    vim.cmd('bdelete!')
  end
end, { force = true })

vim.keymap.set('n', 'Q', '<Cmd>CWKB<cr>', { silent = true })
vim.keymap.set('n', '<leader>w', '<Cmd>write!<cr>')
vim.keymap.set('n', '<leader>ll', '<Cmd>Lazy<cr>')

vim.keymap.set('n', '<leader>vr', '<Cmd>edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>vv', '<Cmd>lcd %:p:h<cr>')

vim.keymap.set('n', '<leader>v', '<Cmd>vsplit<cr>')
vim.keymap.set('n', '<leader>o', '<Cmd>split<cr>')

vim.keymap.set('n', '<leader>W', '<Cmd>set wrap!<cr>')

vim.keymap.set('n', '<leader>x', '<Cmd>let @/ = ""<cr>')

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<right>', '<Cmd>vertical resize +3<cr>')
vim.keymap.set('n', '<left>', '<Cmd>vertical resize -3<cr>')
vim.keymap.set('n', '<down>', '<Cmd>resize +3<cr>')
vim.keymap.set('n', '<up>', '<Cmd>resize -3<cr>')

vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')
