local Log = require('core.log')
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	Log:get_default().error "Failed to load plugin Telescope"
end

local actions = require('telescope.actions')

local M = {}

function M.setup()
	telescope.setup {
			defaults = {
					file_sorter = require('telescope.sorters').get_fzy_sorter,
					prompt_prefix = ' >',
					color_devicons = true,

					file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
					grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
					qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

					mappings = {
							i = {
									["<C-x>"] = false,
									["<C-q>"] = actions.send_to_qflist,
							},
					}
			},
			extensions = {
					fzy_native = {
							override_generic_sorter = false,
							override_file_sorter = true,
					}
			}
	}

	require('telescope').load_extension('fzy_native')

  remap('n', '<C-p>', "require('telescope.builtin').git_files()<CR>", { noremap = true, silent = true })
  remap('n', '<leader>pf', "require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
  remap('n', '<leader>ps', "require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>", { noremap = true, silent = true })
  remap('n', '<leader>pw', "require('telescope.builtin').grep_string { search = vim.fn.expand(\"<cword>\") }<CR>", { noremap = true, silent = true })
  remap('n', '<leader>pf', "require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
	remap('n', '<leader>pb', "require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
	remap('n', '<leader>vh', "require('telescope.builtin').help_tags()<CR>", { noremap = true, silent = true })
end


return M
