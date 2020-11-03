" better split navigation
    map <nowait> <C-h> <C-w>h
    map <nowait> <C-j> <C-w>j
    map <nowait> <C-k> <C-w>k
    map <nowait> <C-l> <C-w>l

" better splitting
    nnoremap <leader>vv :vsplit<CR>
	nnoremap <leader>hh :split<CR>

" split resizing
    map <Right> :vertical resize +5<CR>
    map <Left> :vertical resize -5<CR>
    map <Up> :resize +5<CR>
    map <Down> :resize -5<CR>

" move selected lines up or down
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

" fix changing indentation in visual mode
	vmap > >gv
	vmap < <gv

" buffer/tab switching keybinds
	" close the current buffer and move to the previous one
	" this replicates the idea of using a tab, but actually not using one
	nnoremap <leader>qq :bp<BAR>bd #<CR>
	" move to the next buffer
    noremap <silent> <Tab> :bn<CR>
	" move to the previous buffer
    noremap <silent> <S-Tab> :bp<CR>
	" show all open buffers and their status
	noremap <leader>bl :ls<CR>

	" new tab
	noremap <silent> <A-t> :tabnew<CR>
	" move to the next tab
	noremap <A-Tab> :tabnext<CR>
	" move to the previous tab
	noremap <A-S-Tab> :tabnext<CR>
	" move the current tab up or down
	noremap <silent> <A-2> :tabmove +<CR>
	noremap <silent> <A-1> :tabmove -<CR>

" substitute in entire file
    nnoremap S :%s//g<Left><Left>

" source config
    nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" undotree
    nnoremap <leader>u :UndotreeShow<CR>

" search in devdocs
    nmap <leader>dc :DevDocs<SPACE>

" activate goyo bind
    nnoremap <leader>GG :Goyo \| :highlight Normal guibg=none<CR>


    vnoremap X "_d
    inoremap <C-c> <esc>


" better searching:
" highlights words while searching (fzf style)
	set hlsearch
" add the ability to cancel the search with escape
	nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
