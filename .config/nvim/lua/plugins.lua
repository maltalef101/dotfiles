-- Check if packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
		execute('!git clone https://github.com/wbthomason/packer.nvim ' ..install_path)
		execute('packadd packer.nvim')
end

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- LSP magic
	use 'neovim/nvim-lspconfig'

	-- Galaxyline
	use { 'glepnir/galaxyline.nvim',
		branch = 'main',
		config = function() require "core.galaxyline" end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	}

	use	{ 'kabouzeid/nvim-lspinstall',
		event = 'VimEnter',
		config = function() require('lspinstall').setup() end,
	}

	use { 'hrsh7th/nvim-compe',
		event = "InsertEnter",
		config = function() require('core.compe') end,
		requires = 'hrsh7th/vim-vsnip',
	}

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		config = function() require('core.treesitter') end,
		run = ':TSUpdate',
		requires = 'nvim-treesitter/nvim-treesitter-textobjects'
	}

	-- Telescope for fuzzy file-searching
	use { 'nvim-telescope/telescope.nvim',
		config = function() require('core.telescope') end,
		requires = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim'
		},
	}

	-- Gruvbox !!1!11
	use { 'ellisonleao/gruvbox.nvim',
		requires = 'rktjmp/lush.nvim',
	}

	-- Git related plugins
	use 'tpope/vim-fugitive'
	use { 'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function() require('gitsigns').setup() end,
		event = 'BufRead',
	}

	-- nerdfonts
	use 'lambdalisue/nerdfont.vim'

	-- NvimTree
	use { 'kyazdani42/nvim-tree.lua',
		config = function() require('core.nvimtree').setup() end
	}

	-- indent-blankline
	use { "lukas-reineke/indent-blankline.nvim",
		event = 'BufRead',
		config = function() require('core.indent-blankline').setup() end,
	}

	-- autocomplete closing brackets and such
	use { 'windwp/nvim-autopairs',
		config = function() require('core.autopairs') end,
    requires = 'kyazdani42/nvim-web-devicons',
		after = "nvim-compe",
	}

	use { 'norcalli/nvim-colorizer.lua',
		config = function() require('core.colorizer') end,
	}

	use { 'romgrk/barbar.nvim',
    requires =  'kyazdani42/nvim-web-devicons',
	}

end)
