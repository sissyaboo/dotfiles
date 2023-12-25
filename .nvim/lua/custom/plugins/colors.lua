return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      integrations = {
        treesitter_context = true,
        fidget = true,
        mason = true,
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
