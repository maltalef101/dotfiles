local M = {}

function M.setup()
	local nvim_tree_config = require('nvim-tree.config')

	for opt, val in pairs(mvim.builtin.nvimtree) do
		vim.g["nvim_tree_" .. opt] = val
	end

	require('nvim-tree.config')
end

return M
