-- Check if packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then 
		execute('!git clone https://github.com/wbthomason/packer.nvim ' ..install_path)
		execute 'packadd packer.nvim'
end

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

--[[	use {
		'glepnir/galaxyline.nvim',
    branch = 'main',
		config = function() require('core.galaxyline') end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}]]--

	-- LSP magic
	use 'neovim/nvim-lspconfig'

	use	{ 'kabouzeid/nvim-lspinstall',
		event = 'VimEnter',
		config = function() require('lspinstall').setup() end,
	}

	use { 'hrsh7th/nvim-compe',
		config = function() require('core.compe') end,
		requires = 'hrsh7th/vim-vsnip'
	 }

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		config = function() 
			require('core.treesitter')
		end,
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
	use 'gruvbox-community/gruvbox'

	-- Status bar/Tab bar/Buffer bar
	use 'vim-airline/vim-airline'

	-- Git related plugins
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'

	-- nerdfonts
	use 'lambdalisue/nerdfont.vim'

	-- fern
	use { 'lambdalisue/fern.vim',
		config = function() require('core.fern') end,
		requires = {
			'lambdalisue/fern-renderer-nerdfont.vim',
			'lambdalisue/fern-hijack.vim',
			'lambdalisue/fern-git-status.vim'
		}
	}

	-- autocomplete closing brackets and such
	use { 'windwp/nvim-autopairs',
		config = function() require('core.autopairs') end,
	}
end)
