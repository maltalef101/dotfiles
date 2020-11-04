" Set spellchecker and its language with tex files
	setlocal spell spelllang=es_AR
" Run compiler script on writing tex file
	autocmd BufWritePost *.tex !compiler % >/dev/null
" Clean build files of a LaTeX/XeLaTeX build
	autocmd	VimLeave *.tex silent !texclear % >/dev/null
