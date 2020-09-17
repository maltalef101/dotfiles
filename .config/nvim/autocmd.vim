" Call a set command for removing autocommenting on newlines
    autocmd FileType * set formatoptions-=cro

" Call a custom function for trimming trailing whitespaces before writing file
    autocmd BufWritePre * :call TrimWhitespace()

" LaTeX autocmds
    " Fix tex filetype autosetting
        autocmd BufRead,BufNewFile *.tex set filetype=tex
    " Set spellchecker and its language with tex files
        autocmd FileType tex setlocal spell spelllang=es_AR
    " Run compiler script on writing tex file
        autocmd BufWritePost *.tex silent !compiler % >/dev/null
    " Clean build files of a LaTeX/XeLaTeX build
        autocmd BufLeave *.tex silent !texclear % >/dev/null

" Re-source init.vim when saved
    autocmd BufWritePost init.vim :so %

" Recompile dwmblocks when saved
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

" Recompile dwm when saved
    autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/; make && sudo make install && make clean
