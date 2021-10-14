local Log = require('core.log')
local status_ok, comment = pcall(require, 'nvim_comment')
if not status_ok then
	Log:get_default().error "Failed to load plugin"
end

local M = {}

function M.setup()
	comment.setup(mvim.builtin.comment)
	remap('n', '++', ':CommentToggle<CR>', { silent = true, noremap = true })
	remap('v', '++', ":'<,'>CommentToggle<CR>", { silent = true, noremap = true })
end

return M
