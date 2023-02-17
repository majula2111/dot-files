:set autoindent
:set tabstop=2
:set smarttab
:set softtabstop=2
:set mouse=a
:set encoding=UTF-8
:set updatetime=300
:set guifont=JetBrainsMono\ Nerd\ Font
:set termguicolors
:set autoread
:set relativenumber
:set number 

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/ajmwagar/vim-deus'
Plug 'https://github.com/morhetz/gruvbox'

call plug#end()

" theme
colorscheme gruvbox

nnoremap <C-n> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

" coc config

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
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

" ale config

let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \ 'json': ['jq']
 \ }

let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nmap <silent> <C-p> :ALEFix<CR>

" gitgutter config
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

let g:gitgutter_set_sign_backgrounds = 0

" copy to clipboard macos
vnoremap <C-c> :w !pbcopy<CR><CR>
noremap <C-v> :r !pbpaste<CR><CR>
