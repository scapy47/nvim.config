local capabilities = vim.tbl_deep_extend('force',
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    --  PERF: Format on save
    if client:supports_method('textDocument_formatting', bufnr) then
        vim.api.nvim_create_autocmd('bufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end
        })
    else
        vim.notify("Formatting is not supported. forcing autocommand", vim.log.levels.WARN)
        vim.api.nvim_create_autocmd('bufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end
        })
    end
end


local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        vim.fn.expand('$VIMRUNTIME/lua'),
                        vim.fn.stdpath('config') .. '/lua',
                    },
                },
            },
        },
    },
    clangd = {},
    rust_analyzer = {}
}


for server_name, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end

require("mason-tool-installer").setup {
    ensure_installed = {},
    integrations = {
        ['mason-lspconfig'] = true
    }
}

require("mason-lspconfig").setup {
    automatic_installation = false,
    ensure_installed = {},
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = capabilities
            server.on_attach = on_attach
            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
        end
    }
}
