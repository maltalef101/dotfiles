local M = {}

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim/'

function M.packer_installed()
	if fn.empty(fn.glob(install_path)) > 0 then
		return false
	else
		return true
	end
end

function M.install_packer()
	fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.cmd('packadd packer.nvim')
end

function M:load()
	require('plugins.plugins')
end

return M
