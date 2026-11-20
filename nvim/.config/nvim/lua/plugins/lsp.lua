    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = {
              globals = { 'vim' },
              disable = { 'missing-fields' },
            },
            format = {
              enable = false,
            },
          },
        },
      },
      ruff = {},
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              mccabe = { enabled = false },
              pylsp_mypy = { enabled = false },
              pylsp_black = { enabled = false },
              pylsp_isort = { enabled = false },
            },
          },
        },
      },
      qmlls = {},
      jdtls = {}, -- java
      bashls = {},
      ts_ls = {}, -- javascript/typescript
      jsonls = {}, -- json
      sqlls = {},
      terraformls = {},
      yamlls = {},
      dockerls = {},
      docker_compose_language_service = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },
    }

    -- Consolidate all LSPs, linters, and formatters into a single list
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',     -- Lua formatter
      'shellcheck', -- Shell linter
      'shfmt',      -- Shell formatter
      'prettier',   -- JS/TS/JSON/YAML/HTML formatter
      'eslint_d',   -- Fast JS/TS linter
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for server, cfg in pairs(servers) do
      cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end

