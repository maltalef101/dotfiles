let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-eslint',
	\ 'coc-git',
	\ 'coc-json',
	\ 'coc-marketplace',
	\ 'coc-pairs',
	\ 'coc-phpls',
	\ 'coc-python',
	\ 'coc-rls',
	\ 'coc-rust-analyzer',
	\ 'coc-sh',
	\ 'coc-snippets',
	\ 'coc-texlab',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-xml',
	\ 'coc-yaml'
    \ ]

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)
nmap <leader>ol <Plug>(coc-openlink)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <C-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
