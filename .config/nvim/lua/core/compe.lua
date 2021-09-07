vim.o.completeopt = "menuone,noselect"
local Log = require('core.log')

local function prequire(...)
	local status_ok, lib = pcall(require, ...)
	if not status_ok then
		Log:get_default().error "Failed to load plugin compe"
	else
		return lib
	end
end

local status_ok, compe = pcall(require, 'compe')
if not status_ok then
	Log:get_default().error "Failed to load plugin compe"
end

local M = {}

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
			return true
	else
			return false
	end
end

function M.setup()
	local compe = prequire('compe')
	local luasnip = prequire('luasnip')
	compe.setup(mvim.builtin.compe)

	remap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
	remap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
	remap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
	remap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
	remap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
	remap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

	-- Use (s-)tab to:
	--- move to prev/next item in completion menuone
	--- jump to prev/next snippet's placeholder
	_G.tab_complete = function()
		if vim.fn.pumvisible() == 1 then
			return t "<C-n>"
		elseif luasnip and luasnip.expand_or_jumpable() then
			return t "<Plug>luasnip-expand-or-jump"
		elseif check_back_space() then
			return t "<Tab>"
		else
			return vim.fn['compe#complete']()
		end
	end

	_G.s_tab_complete = function()
		if vim.fn.pumvisible() == 1 then
			return t "<C-p>"
		elseif luasnip and luasnip.jumpable(-1) then
			return t "<Plug>luasnip-jump-prev"
		else
			-- If <S-Tab> is not working in your terminal, change it to <C-h>
			return t "<S-Tab>"
		end
	end

end

return M
