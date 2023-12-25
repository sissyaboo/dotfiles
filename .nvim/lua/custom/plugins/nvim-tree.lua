return {
  'nvim-tree/nvim-tree.lua',
  event = "VeryLazy",
  keys = {
    { '<leader>e', '<Cmd>NvimTreeToggle<cr>' },
  },
  version = 'nightly',
  dependencies = {
    'nvim-tree/nvim-web-devicons', lazy = true,
  },
  config = function()
    require('nvim-tree').setup({
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local opts = function(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'mv', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'cc', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'D', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Expand'))
        vim.keymap.set('n', 'h', api.node.open.edit, opts('Close'))
        vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', 'c', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      end,
      update_focused_file = { enable = true },
      hijack_cursor = true,
      reload_on_bufenter = true,
      view = {
        cursorline = false,
      },
      filters = {
        custom = { ".DS_Store" },
      },
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
        icons = {
          glyphs = {
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '',
              untracked = '',
              deleted = '',
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
}
