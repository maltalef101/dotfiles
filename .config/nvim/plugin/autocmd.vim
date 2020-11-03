" Call a set command for removing autocommenting on newlines
    autocmd FileType * set formatoptions-=cro

" Call a custom function for trimming trailing whitespaces before writing file
    autocmd BufWritePre * :call TrimWhitespace()

" Re-source init.vim when saved
    autocmd BufWritePost init.vim :so %

" Recompile dwmblocks when saved
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

