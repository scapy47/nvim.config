local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require("cmp_nvim_lsp")
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


lspconfig.lua_ls.setup{
	capabilities = capabilities
}
lspconfig.rust_analyzer.setup{
	capabilities = capabilities
}
lspconfig.clangd.setup{
	capabilities = capabilities
}
