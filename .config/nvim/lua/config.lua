TERM = vim.fn.expand('$TERMINAL')
USER = vim.fn.expand('$USER')
HOME = vim.fn.expand('$HOME')
CACHE_PATH = vim.fn.stdpath('cache')
DATA_PATH = vim.fn.stdpath "data"

local util = require('lspconfig/util')

remap = vim.api.nvim_set_keymap

local common_capabilities = require('lsp').common_capabilities()
local common_on_attach = require('lsp').on_attach()

local common_root= util.root_pattern(".git")

mvim = {
  log = {
    ---@usage can be { "trace", "debug", "info", "warn", "error", "fatal" },
    level = "warn",
  },
	builtin = {
		nvimtree = {
			side = "left",
			width = 30,
			show_icons = {
				git = 1,
				folders = 1,
				files = 1,
				folder_arrows = 1,
				tree_width = 30,
			},
			ignore = { "node_modules", ".cache" },
			auto_open = 1,
			auto_close = 1,
			quit_on_open = 0,
			follow = 1,
			hide_dotfiles = 1,
			git_hl = 1,
			root_folder_modifier = ":t",
			tab_open = 0,
			allow_resize = 1,
			lsp_diagnostics = 1,
			auto_ignore_ft = { 'startify', 'dashboard' },
			icons = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
		compe = {

		},
	},
	lsp = {
		completion = {
			item_kind = {
				"   (Text) ",
        "   (Method)",
        "   (Function)",
        "   (Constructor)",
        " ﴲ  (Field)",
        "[] (Variable)",
        "   (Class)",
        " ﰮ  (Interface)",
        "   (Module)",
        " 襁 (Property)",
        "   (Unit)",
        "   (Value)",
        " 練 (Enum)",
        "   (Keyword)",
        "   (Snippet)",
        "   (Color)",
        "   (File)",
        "   (Reference)",
        "   (Folder)",
        "   (EnumMember)",
        " ﲀ  (Constant)",
        " ﳤ  (Struct)",
        "   (Event)",
        "   (Operator)",
        "   (TypeParameter)",
			},
		},
		diagnostics = {
			signs = {
				active = true,
				values = {
          { name = 'LspDiagnosticsSignError', text = '' },
          { name = 'LspDiagnosticsSignWarning', text = '' },
          { name = 'LspDiagnosticsSignHint', text = '' },
          { name = 'LspDiagnosticsSignInformation', text = '' },
        },
			},
			virtual_text = {
				prefix = '',
				spacing = 1,
			},
			underline = true,
			severity_sort = true,
		},
		document_highlight = true,
		popup_border = 'single',
	},
	lang = {
		lua = {
			formatters = {
				{
					exe = "",
					args = {},
				},
			},
			linters = {},
			lsp = {
				provider = 'sumneko_lua',
				setup = {
					cmd = {
						DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
						"-E",
						DATA_PATH .. "/lspinstall/lua/main.lua",
					},
					root_dir = common_root,
					on_attach = common_on_attach,
					filetypes = { 'lua' },
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
								path = vim.split(package.path, ";"),
								-- Hover definitions
								hover = {
									enable = true,
								},
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { 'vim', 'mvim' },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = {
									[vim.fn.expand('$VIMRUNTIME/lua')] = true,
									[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
								},
								maxPreload = 100000,
								preloadFileSize = 1000,
								checkThirdParty = false, -- This is so it doesn't try to change my workspace settings to "LÖVE"
							},
						}
					},
					capabilities = common_capabilities,
				},
			},
		},
		cpp = {
			formatters = {
				{
					exe = "",
					args = {},
				},
			},
			linters = {},
			lsp = {
				provider = "clangd",
				setup = {
					cmd = { 'clangd' , '--background-index' },
					settings = { },
				},
			},
		},
		tex = {
			lsp = {
				provider = 'texlab',
				setup = {
					cmd = { DATA_PATH .. "/lspinstall/latex/texlab" },
					settings = {
						--[[texlab = {
							build = {
								executable = 'compiler',
								args = { '%f' },
								onSave = true,
							},
							chktex = {
								onEdit = false,
								onOpenAndSave = true,
							},
							latexFormatter = 'latexindent',
							latexindent = {
								modifyLineBreaks = false,
							}
						}]]
					},
				},
			},
		},
		bib = {
			lsp = {
				provider = 'texlab',
				setup = {
					cmd = { DATA_PATH .. "/lspinstall/latex/texlab" },
				},
			},
		},
		python = {
			lsp = {
				provider = 'pyright',
				setup = {
					cmd = {
						DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
          "--stdio",
					},
					root_dir = common_root,
					on_attach = common_on_attach,
				},
			},
		},
	},
	treesitter = {
		ensure_installed = { 'lua', 'cpp', 'latex', 'cmake'}, -- list of languages
		ignore_install = {}, -- list of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
			additional_vim_regex_highlighting = false,
		},
	},
}

return mvim
