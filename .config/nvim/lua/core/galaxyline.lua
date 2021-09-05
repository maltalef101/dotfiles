local Log = require('core.log')

local status_ok, gl = pcall(require, 'galaxyline')
if not status_ok then
	Log:get_default().error "Failed to load plugin"
	return
end

local colors = {
	bg = '#282828',
	bg0_h = '#1d2021',
	bg1 = '#3c3836',
	bg2 = '#504945',
	bg3 = '#665c54',
	bg4 = '#7c6f64',
	fg = '#ebdbb2',
	red = '#cc241d',
	light_red = '#fb4934',
	green = '#98971a',
	light_green = '#b8bb26',
	yellow = '#d79921',
	light_yellow = '#fabd2f',
	blue = '#458588',
	light_blue = '#83a598',
	purple = '#b16286',
	light_purple = '#d8369b',
	aqua = '#689d6a',
	light_aqua = '#8ec07c',
	orange = '#d65d0e',
	light_orange = '#fe8019',
	gray = '#928374',
	light_gray = '#a89984',
	hex_white = '#ffffff',
	hex_black = '#000000',
}

local condition = require "galaxyline.condition"
local gls = gl.section
gl.short_line_list = { "vista", "dbui", "NvimTree", "packer"}

local function get_mode_name()
  local names = {
    n = "NORMAL",
    i = "INSERT",
    c = "COMMAND",
    v = "VISUAL",
    V = "V-LINE",
    t = "TERMINAL",
    R = "REPLACE",
    [""] = "V-BLOCK",
  }
  return names[vim.fn.mode()]
end

local mode_color = {
	n = colors.gray,
	i = colors.light_blue,
	v = colors.light_orange,
	[""] = colors.light_orange,
	V = colors.light_orange,
	c = colors.light_green,
	no = colors.blue,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.red,
	Rv = colors.red,
	cv = colors.blue,
	ce = colors.blue,
	r = colors.aqua,
	rm = colors.aqua,
	["r?"] = colors.aqua,
	["!"] = colors.blue,
	t = colors.blue,
}

gls.left[1] = {
  ViMode = {
    provider = function()
			local name = get_mode_name()

			vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color[vim.fn.mode()])
			return '  ' .. name .. ' '
    end,
		highlight = { colors.bg, colors.fg, 'bold'},
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg0_h },
  },
}

gls.left[4] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = condition.check_git_workspace,
		icon = "+",
		separator = '',
		separator_highlight = { 'NONE', colors.bg0_h },
		highlight = { colors.light_green, colors.bg0_h }
	}
}
gls.left[5] = {
	DiffModified = {
		provider = "DiffModified",
		condition = condition.check_git_workspace,
		icon = "~",
		separator = '',
		separator_highlight = { 'NONE', colors.bg0_h },
		highlight = { colors.light_aqua, colors.bg0_h }
	}
}

gls.left[6] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = condition.check_git_workspace,
		icon = "-",
		separator = '',
		separator_highlight = { 'NONE', colors.bg0_h },
		highlight = { colors.light_red, colors.bg0_h }
	}
}

gls.left[7] =  {
	GitBranch = {
		icon = "שׂ ",
		provider = "GitBranch",
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg0_h },
		condition = condition.check_git_workspace,
		highlight = { colors.orange, colors.bg0_h },
	}
}

gls.left[8] = {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg1 },
		icon = ' ',
		separator_highlight = { 'NONE', colors.bg1 }
	}
}

gls.left[9] = {
	FileName = {
		provider = 'FileName',
		condition = condition.buffer_not_empty,
		highlight = { colors.light_gray, colors.bg1 }
	}
}

gls.mid[1] = {
	ShowLspClient = {
		provider = "GetLspClient",
		condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP: ',
		highlight = { colors.light_gray, colors.bg }
	},
}

gls.right[1] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}

gls.right[2] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.orange, colors.bg },
	},
}

gls.right[3] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { colors.blue, colors.bg },
	},
}

gls.right[4] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  ",
		highlight = { colors.yellow, colors.bg },
	},
}

gls.right[6] = {
	LineInfo = {
		provider = "LineColumn",
		separator = "  ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.gray, colors.bg },
	}
}

gls.right[7] = {
	PerCent = {
		provider = "LinePercent",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.gray, colors.bg },
	}
}

gls.right[8] = {
	Tabstop = {
		provider = function()
			return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
		end,
		condition = condition.hide_in_width,
		separator = " ",
		separator_highlight = {"NONE", colors.bg},
		highlight = {colors.gray, colors.bg}
	}
}

gls.right[9] = {
	BufferType = {
		provider = "FileTypeName",
		condition = condition.hide_in_width,
		separator = " ",
		separator_highlight = {"NONE", colors.bg},
		highlight = {colors.grey, colors.bg}
	}
}

gls.right[10] = {
	FileEncode = {
		provider = "FileEncode",
		condition = condition.hide_in_width,
		separator = " ",
		separator_highlight = {"NONE", colors.bg},
		highlight = {colors.grey, colors.bg}
	}
}

gls.right[11] = {
	Space = {
		provider = function() return " " end,
	}
}

gls.right[12] = {
	Block = {
		provider = function() 
			vim.cmd("hi GalaxyBlock guibg=" .. mode_color[vim.fn.mode()])

			return " " 
		end,
		highlight = { "NONE", mode_color[vim.fn.mode()] }
	}
}
