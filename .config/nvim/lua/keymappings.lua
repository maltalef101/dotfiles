-- Set leader
remap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Resource init.lua
remap('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>', { noremap = true })

-- nvim-tree binding
remap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Better split navigation
remap('n', '<C-h>', '<C-w>h', { silent = true })
remap('n', '<C-j>', '<C-w>j', { silent = true })
remap('n', '<C-k>', '<C-w>k', { silent = true })
remap('n', '<C-l>', '<C-w>l', { silent = true })

-- Better splitting
remap('n', '<Leader>vv', ':vsplit<CR>', { silent = true })
remap('n', '<Leader>hh', ':split<CR>', { silent = true })

-- Split resizing
remap('n', '<Right>', ':vertical resize +5<CR>', { silent = true })
remap('n', '<Left>', ':vertical resize -5<CR>', { silent = true })
remap('n', '<Up>', ':resize +5<CR>', { silent = true })
remap('n', '<Down>', ':resize -5<CR>', { silent = true })

-- Fix reindentation
remap('v', '>', '>gv', {})
remap('v', '<', '<gv', {})

-- Buffer/Tab switching
remap('n', '<Leader>qq', ':BufferClose<CR>', { noremap = true, silent = true})
remap('n', '<Tab>', ':BufferNext<CR>', { noremap = true, silent = true})
remap('n', '<S-Tab>', ':BufferPrevious<CR>', { noremap = true, silent = true})
remap('n', '<Leader>bl', ':ls<CR>', { noremap = true})
