-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- netrw binding
vim.api.nvim_set_keymap('n', '<Leader>e', ':<CR>', { noremap = true, silent = true })
