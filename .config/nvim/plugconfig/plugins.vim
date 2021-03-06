" install vim-plug if not already installed
if ! filereadable(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim/site/autoload
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Where plugins are actually defined
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Syntax highlighting
    Plug 'PotatoesMaster/i3-vim-syntax'
" Autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" dealing with surroundings
    Plug 'tpope/vim-surround'
" (X)HTML tag autoclosing and renaming when name changed
    Plug 'alvan/vim-closetag'
    Plug 'AndrewRadev/tagalong.vim'
" Documentation searching
    Plug 'rhysd/devdocs.vim'
" Git-related plugins
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
" Commenter (bc i don't like to use vblocks)
    Plug 'preservim/nerdcommenter'
" fern bc netrw is kinda junky
    Plug 'lambdalisue/fern.vim'
	Plug 'lambdalisue/fern-renderer-nerdfont.vim'
	Plug 'lambdalisue/fern-hijack.vim'
	Plug 'lambdalisue/fern-git-status.vim'
" nerdfonts stuff
	Plug 'lambdalisue/nerdfont.vim'
" Highlight color values
    Plug 'ap/vim-css-color'
" Gives you a nice undo tree for easy unfuckup-ing
    Plug 'mbbill/undotree'
" Literally the only good language pack for vim
    Plug 'sheerun/vim-polyglot'
" Fuzzy file searching
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
" Write CSS faster
    Plug 'rstacruz/vim-hyperstyle'
" colorschemes!!
    Plug 'gruvbox-community/gruvbox'
    Plug 'flazz/vim-colorschemes'
" Status bar/Tab bar/Buffer bar
    Plug 'vim-airline/vim-airline'
" Goyo for nice prose writing
    Plug 'junegunn/goyo.vim'
" vimtex because why wouldn't you use it
    Plug 'lervag/vimtex'
" debbuging in vim!
	Plug 'puremourning/vimspector'
	Plug 'szw/vim-maximizer'
call plug#end()
