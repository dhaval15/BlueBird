call plug#begin('~/.vim/plugged')

Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

Plug 'morhetz/gruvbox'

Plug 'preservim/nerdtree'

Plug 'dart-lang/dart-vim-plugin'

Plug 'natebosch/vim-lsc'

Plug 'natebosch/vim-lsc-dart'

call plug#end()

let g:lsc_auto_map = v:true

set complete+=kspell

set relativenumber
