local M = {}

function M.load_options()
	local opt = vim.opt

	local options = {
		-- vim.fn.path+=**
		-- vim.fn.wildignore=**/node_modules/**
		--set formatoptions-=cro
		shadafile = "NONE", -- don't write to a shada file
		autoindent = true,
		signcolumn = "yes",
		backup = false, -- creates a backup file
		background = 'dark', -- dark themed gruvbox
		clipboard = 'unnamedplus', -- allow neovim to access the system clipboard
		cmdheight = 2, -- more space in the neovim command line for displaying messages
		completeopt = { 'menuone', 'noselect' },
		conceallevel = 0, -- so that `` is visible in markdown files
		cursorcolumn = true, -- highlight the current column
		cursorline = true, -- highlight the current line
		encoding = "utf-8", -- the encoding written to a file
		errorbells = false, -- disable terminal bells
		foldexpr = '', -- set to 'nvim_treesitter#foldexpr()' for treesittter based folding
		foldmethod = 'manual', -- folding. set to 'expr' for treesittter based folding
		hidden = true, -- required for multiple buffers to be left open
		history = 100, -- command history
		hlsearch = false, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		incsearch = true,
		mouse = 'a', -- allow the mouse to be used in neovim
		number = true, -- set numbered lines
		pumheight = 10, -- Pop Up Menu height
		relativenumber = true, -- set relative numbered lines
		scrolloff = 8, -- is one of my fav
		shiftwidth = 4,
		showtabline = 2,
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		sidescrolloff = 8,
		smartcase = true, -- smart case
		smartindent = true, --make indenting smarter again
		softtabstop = 4,
		splitbelow = true, -- force all horizontal splits to go below the current window
		splitright = true, -- force all vertical splits to go to the right of the current window
		swapfile = false, -- creates a swapfile
		tabstop = 4,
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 200, -- time to wait for a mapped sequence to to complete (in milliseconds)
		undodir = CACHE_PATH .. "/undo", -- set an undo directory
		undofile = true, -- enable persistent undo
		updatetime = 300, -- faster completion
		wrap = false, -- line wrapping
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	}

	opt.shortmess:append('casI')

	for k, v in pairs(options) do
		vim.opt[k] = v
	end

end

function M.disable_builtins()
	local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
	}

	for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
	end
end

function M.colorscheme()
	-- Colorscheme
	require('colorbuddy').colorscheme('gruvbox')
end

return M
