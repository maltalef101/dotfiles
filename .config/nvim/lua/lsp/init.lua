local M = {}

function M.global_setup()
	vim.lsp.protocol.CompletionItemKind = mvim.lsp.completion.item_kind

	for _, sign in ipairs(mvim.lsp.diagnostics.signs.values) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name})
	end

	require('lsp.handlers').setup()
end

local function lsp_highlight_document(client)
	if mvim.lsp.document_highlight == false then
		return
	end

	if client.resolved_capabilities.document_highlight then
		vim.cmd("hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46")
		vim.cmd("hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46")
		vim.cmd("hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46")

	-- Set autocommands conditional on server_capabilities
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
	end

	vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
end

local function add_lsp_buf_keybinds(bufnr)
	local function buf_remap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	buf_remap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
	buf_remap('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gp', "<cmd>lua require('lsp.peek').Peek('definition')<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gs', "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'gl', "<cmd>lua require'lsp.handlers'.show_line_diagnostics()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'd]', "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
	buf_remap('n', 'd[', "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

	buf_remap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>ws', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
	buf_remap('n', '<leader>wS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
end

function M.common_on_attach(client, bufnr)
	lsp_highlight_document(client)
	add_lsp_buf_keybinds(bufnr)
end

function M.setup(lang)
	local lsp = mvim.lang[lang].lsp

	if lsp.provider ~= nil and lsp.provider ~= "" then
		local lspconfig = require('lspconfig')

		if not lsp.setup.on_attach then
			lsp.setup.on_attach = M.common_on_attach
		end

		if not lsp.setup.capabilities then
			lsp.setup.capabilities = M.common_capabilities()
		end

		lspconfig[lsp.provider].setup(lsp.setup)
		vim.cmd("LspStart")
	end
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
