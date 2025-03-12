local lspconfig = require('lspconfig')

local capabilities = vim.tbl_deep_extend('force', {},
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local function on_attach(client, bufnr)
    --  PERF: Format on save
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('bufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end
        })
    end
end


local servers = {
    lua_ls = {},
    clangd = {}
}

-- TODO: add mason-tool-installer

for server_name, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    lspconfig[server_name].setup(config)
end

require("mason-tool-installer").setup {
    ensure_installed = {},
    integrations = {
        ['mason-lspconfig'] = true
    }
}

require("mason-lspconfig").setup {
    automatic_installation = false,
    ensure_installed = {}, -- explicitly empty (handled by mason-tool-installer)
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = capabilities
            server.on_attach = on_attach
            lspconfig[server_name].setup(server)
        end
    }
}
