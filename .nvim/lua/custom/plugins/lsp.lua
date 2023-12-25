return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '')
        nmap('K', vim.lsp.buf.hover, '')
        nmap('<leader>ca', vim.lsp.buf.code_action, '')
      end

      local servers = {
        eslint = {},
        cssls = {},
        jsonls = {},
        html = {},
        tailwindcss = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
              },
            },
          },
        },
        bashls = {
          bashIde = {
            includeAllWorkspaceSymbols = true,
          },
        },
        tsserver = {},
        lua_ls = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
            diagnostic = {
              globals = { 'vim' },
            },
          },
        },
      }

      require('neodev').setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason').setup()

      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })

      require('mason-tool-installer').setup({
        ensure_installed = {
          'bash-language-server',
          'tailwindcss-language-server',
          'typescript-language-server',
          'prisma-language-server',
          'lua-language-server',
          'markdownlint',
          'beautysh',
          'html-lsp',
          'css-lsp',
          'eslint-lsp',
          'eslint_d',
          'json-lsp',
          'css-lsp',
          'yamlfmt',
          'stylua',
          'shfmt',
          'shellharden',
          'shellcheck',
        },
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    lazy = true,
    event = { 'LspAttach', 'BufReadPost', 'BufAdd', 'BufNewFile' },
    tag = 'legacy',
    opts = {}
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require('null-ls')

      local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
      local event = 'BufWritePre'
      local async = event == 'BufWritePost'
      local builtins = null_ls.builtins

      null_ls.setup({
        sources = {
          builtins.formatting.shfmt.with({
            extra_args = { '-i', '2', '-ci', '-bn', '-sr' },
          }),
          builtins.formatting.shellharden,
          builtins.formatting.beautysh.with({
            disabled_filetypes = { 'sh', 'bash' },
          }),
          builtins.formatting.prettier,
          builtins.formatting.trim_whitespace,
          builtins.formatting.trim_newlines,
          builtins.diagnostics.markdownlint,
          builtins.code_actions.gitsigns,
        },
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = '[lsp] format on save',
            })
          end
        end,
      })
    end,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    keys = {
      { '<leader>dd', '<Cmd>TroubleToggle document_diagnostics<cr>' },
      { '<leader>dl', '<Cmd>TroubleToggle loclist<cr>' },
      { '<leader>dq', '<Cmd>TroubleToggle quickfix<cr>' },
      { '<leader>dr', '<Cmd>TroubleToggle lsp_references<cr>' },
      { '<leader>dt', '<Cmd>TroubleToggle lsp_type_definitions<cr>' },
      { '<leader>dw', '<Cmd>TroubleToggle lsp_implementations<cr>' },
      { '<leader>q',  '<Cmd>TroubleToggle workspace_diagnostics<cr>' },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true, },
    config = function()
      require('trouble').setup({
        auto_close = true,
      })
    end,
  },
}
