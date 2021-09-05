local M = {}

function M.config()
	vim.lsp.protocol.CompletionItemKind = mvim.lsp.completion.item_kind

	for _, sign in ipairs(mvim.lsp.diagnostics.signs.values) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name})
	end

	require('lsp.handlers').setup()
end

function M.on_attach(_, bufnr)
	local function buf_remap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	buf_remap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>', { noremap = true, silent = true })
	buf_remap('n', 'd]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'd[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

	buf_remap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>ws', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>wS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
end

function M.setup(lang)
	local lsp = mvim.lang[lang].lsp

	local lspconfig = require('lspconfig')
	lspconfig[lsp.provider].setup(lsp.setup)
end

function M.common_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits'
		}
	}

	return capabilities
end

return M
