local Log = require('core.log')

local status_ok, ibl = pcall(require, 'indent_blankline')
if not status_ok then
	Log:get_default().error "Error loading plugin"
end

local M = {}

function M.setup()
	ibl.setup {
		char = '|',
		buftype_exclude = { 'NvimTree', 'terminal', 'help' },
		show_current_context = true,
	}

	vim.cmd('hi IndentBlanklineContextChar guifg=#6d6f64 gui=bold')
	vim.cmd('hi IndentBlanklineChar gui=bold')
end

return M

