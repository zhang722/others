set nu " line number


syntax on
set showcmd

" tab width
set tabstop=4
" auto indent
set shiftwidth=4
" use space when tab
set expandtab

set pastetoggle=<F5>
noremap <F3> :rightbelow vert term<cr>

set mouse=a
" no backup
set nobackup
set noswapfile
set nowritebackup

set autowrite

set cursorline
" colorscheme molokai
colorscheme PaperColor
set t_Co=256

set laststatus=2
set showtabline=2

let mapleader=";"
imap jk <Esc>
nmap <C-j> <C-f>
nmap <C-k> <C-b>
tnoremap  <C-\><C-\> <C-\><C-n>
" 解决插入模式下delete/backspce键失效问题：
set backspace=2


" plug-vim
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'scrooloose/nerdtree'

call plug#end()

"""""""coc.vim settings
"
"
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction



filetype plugin indent on    " required

highlight PMenu ctermfg=245 ctermbg=237 guifg=black guibg=LightSteelBlue
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black






" nerdtree settings
" auto open nerdtree 
" autocmd vimenter * NERDTree

" exit when only nerdtree is left
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <F4> :NERDTreeMirror<CR>
map <F4> :NERDTreeToggle<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" window width
let g:NERDTreeWinSize=30

let NERDTreeWinPos='left'
