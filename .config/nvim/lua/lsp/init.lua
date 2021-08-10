local M = {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 10,
    },
    signs = true,
    underline = true,
		severity_sort = true,
  }
)


function M.config()
	vim.lsp.protocol.CompletionItemKind = mvim.lsp.completion.item_kind
	vim.lsp.document_highlight = true;
	vim.lsp.popup_border = 'single';
end

function M.setup(lang)
	local lsp = mvim.lang[lang].lsp

	local lspconfig = require('lspconfig')
	lspconfig[lsp.provider].setup(lsp.setup)
end

return M
