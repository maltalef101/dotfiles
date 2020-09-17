" better split navigation
    map <nowait> <C-h> <C-w>h
    map <nowait> <C-j> <C-w>j
    map <nowait> <C-k> <C-w>k
    map <nowait> <C-l> <C-w>l

" better splitting
    nnoremap <leader>vv :vsplit<CR>
	nnoremap <leader>hh :split<CR>

" split resizing
    nnoremap <Leader>+ :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>
    nnoremap <Leader>m+ :resize +5<CR>
    nnoremap <Leader>m- :resize -5<CR>

" move selected lines up or down
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

" fix changing indentation in visual mode
	vmap > >gv
	vmap < <gv

" buffer switching keybinds
	nnoremap <leader>qq :bw<CR>
    nnoremap <leader><Tab> :bn<CR>
    nnoremap <leader><S-Tab> :bp<CR>

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


" arrow keys disable:
    vnoremap <Up> <Nop>
    vnoremap <Down> <Nop>
    vnoremap <Left> <Nop>
    vnoremap <Right> <Nop>
    inoremap <Up> <Nop>
    inoremap <Down> <Nop>
    inoremap <Left> <Nop>
    inoremap <Right> <Nop>
    noremap <Up> <Nop>
    noremap <Down> <Nop>
    noremap <Left> <Nop>
    noremap <Right> <Nop>
