TERM = vim.fn.expand('$TERMINAL')
USER = vim.fn.expand('$USER')
HOME = vim.fn.expand('$HOME')
CACHE_PATH = vim.fn.stdpath('cache')
DATA_PATH = vim.fn.stdpath "data"

remap = vim.api.nvim_set_keymap

local common_capabilities = require('lsp').common_capabilities()
local common_on_attach = require('lsp').common_on_attach


mvim = {
	colorscheme = "gruvbox",
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
			enabled = true;
			autocomplete = true;
			debug = false;
			min_length = 1;
			preselect = 'enable';
			throttle_time = 80;
			source_timeout = 200;
			incomplete_delay = 400;
			max_abbr_width = 100;
			max_kind_width = 100;
			max_menu_width = 150;
			documentation = true;
			source = {
				path = true,
				buffer = true,
				calc = true,
				vsnip = false,
				luasnip = true,
	      nvim_lsp = true,
				nvim_lua = false;
	      spell = true,
				tags = true;
				snippets_nvim = false;
				treesitter = true;
			},
		},
		comment = {
			active = true,
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
			update_in_insert = true,
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
					root_dir = function(fname)
						local util = require("lspconfig/util")

						local root_files = {
							".git"
						}

						return util.root_pattern(unpack(root_files))(fname)
					end,
					on_attach = common_on_attach,
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
						texlab = {
							latexFormatter = 'latexindent',
							latexindent = {
								modifyLineBreaks = true,
							},
							build = {
								executable = 'compiler',
								args = { '%f' },
							}
						}
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
					root_dir = function(fname)
						local util = require("lspconfig/util")

						local root_files = {
							".git",
						}

						return util.root_pattern(unpack(root_files))(fname)
					end,
					on_attach = common_on_attach,
				},
			},
		},
		javascript = {
			lsp = {
				provider = 'tsserver'	,
				setup = {
					cmd = {
						DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
						"--stdio"
					},
					root_dir = function(fname)
						local util = require("lspconfig/util")

						local root_files = {
							"package.json",
							"tsconfig.json",
							"jsconfig.json",
							".git",
						}

						return util.root_pattern(unpack(root_files))(fname)
					end,
					on_attach = common_on_attach,
				},
			},
		},
		html = {
			lsp = {
				provider = 'html',
				setup = {
					cmd = {
						"node",
						DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
						"--stdio"
					},
				}
			},
		},
		gdscript = {
			lsp = {
				provider = 'gdscript',
				setup = {
					cmd = { 'nc', 'localhost', '6008'},
					filetypes = { 'gdscript', 'gd', 'gdscript3' },
					root_dir = function(fname)
						local util = require("lspconfig/util")

						local root_files = {
							"project.godot",
							".git",
						}

						return util.root_pattern(unpack(root_files))(fname)
					end,
				},
			},
		},
-- 		rust = {
-- 			lsp = {
-- 				provider = 'rls',
-- 				setup = {
-- 					cmd = { 'rls' },
-- 					filetypes = { 'rust' },
-- 					root_dir = function(fname)
-- 						local util = require('lspconfig/util')
-- 
-- 						local root_files = {
-- 							"Cargo.toml",
-- 						}
-- 
-- 						return util.root_pattern(unpack(root_files))(fname)
-- 					end,
-- 				},
-- 			},
--  		},
 		rust = {
			lsp = {
				provider = 'rust_analyzer',
				setup = {
					cmd = { 'rust-analyzer' },
					filetypes = { 'rust' },
					root_dir = function(fname)
						local util = require('lspconfig/util')

						local root_files = {
							"Cargo.toml",
						}

						return util.root_pattern(unpack(root_files))(fname)
					end,
				},
			}
		}
	},
	treesitter = {
		ensure_installed = { 'lua', 'cpp', 'latex', 'cmake'}, -- list of languages
		ignore_install = {}, -- list of parsers to ignore installing
    matchup = {
      enable = false, -- mandatory, false will disable the whole extension
      -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = 1000,
		},
	},
}

return mvim
