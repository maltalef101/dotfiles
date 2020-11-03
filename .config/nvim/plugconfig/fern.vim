let g:fern#drawer_width = 30
let g:fern#default_hidden = 1

noremap <leader>pv :Fern . -drawer -toggle<CR>

function! s:init_fern() abort
	nmap <buffer> H <Plug>(fern-action-open:split)
	nmap <buffer> V <Plug>(fern-action-open:vsplit)
	nmap <buffer> R <Plug>(fern-action-rename)
	nmap <buffer> M <Plug>(fern-action-move)
	nmap <buffer> C <Plug>(fern-action-copy)
	nmap <buffer> H <Plug>(fern-action-new-path)
	nmap <buffer> H <Plug>(fern-action-new-file)
	nmap <buffer> H <Plug>(fern-action-new-dir)
	nmap <buffer> H <Plug>(fern-action-hidden-toggle)
	nmap <buffer> H <Plug>(fern-action-remove)
	nmap <buffer> H <Plug>(fern-action-mark)
endfunction

augroup fern-custom
	autocmd! *
	autocmd FileType fern call s:init_fern()
augroup END

let g:fern#renderer = "nerdfont"
