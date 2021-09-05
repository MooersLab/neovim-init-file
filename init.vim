set spell spelllang=en_us
set undofile
set encoding=utf-8

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

set ignorecase
set number
set conceallevel=1
set termguicolors
set background=light
set expandtab
set autoindent
set softtabstop=4
set shiftwidth=2
set tabstop=4
set history=1000

execute 'source /Users/blaine/.config/nvim/autoload/plug.vim'

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

colorscheme solarized

autocmd BufEnter * lcd %:p:h

filetype plugin indent on

set undodir=~/.config/nvim/undodir

call plug#begin()

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'neovim/nvim-lspconfig'

let g:deoplete#enable_at_startup = 1

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'


" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'dense-analysis/ale'
Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
" autompletion in Python
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-snipmate'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-pyclang'
Plug 'jceb/vim-orgmode'
Plug 'Shougo/denite.nvim'
Plug 'rafaqz/citation.vim'
Plug 'vim-scripts/Vimball'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'junegunn/goyo.vim'
Plug 'rust-lang/rust.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/nginx.vim'
" Plug 'ycm-core/YouCompleteMe'
Plug 'coyotebush/vim-pweave'

" --------------- LaTeX related plugins -------------------------------"
Plug 'conornewton/vim-latex-preview'
Plug 'Konfekt/FastFold'
Plug 'matze/vim-tex-fold'
Plug 'lervag/vimtex'
" Plug 'emakman/nvim-latex-previewer'

" =========[ Pomodoro ]=======================================================
Plug 'adelarsq/vim-pomodoro'

Plug 'lukas-reineke/indent-blankline.nvim'

" Currently broken
" Plug 'jbyuki/monolithic.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/neocomplcache.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/SimpylFold'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/nginx.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'coyotebush/vim-pweave'
Plug 'szymonmaszke/vimpyter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hrsh7th/nvim-compe'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'ervandew/supertab'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" barbar tabline
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Install nvim-cmp
" Plug 'hrsh7th/nvim-cmp'

" Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
" Plug 'hrsh7th/vim-vsnip'

" Install the buffer completion source
" Plug 'hrsh7th/cmp-buffer'
call plug#end()


" =========[ monolithic ]======================================================
" https://github.com/jbyuki/monolithic.nvim
" Recommended key binding
nnoremap <leader>s :lua require"monolithic".open()<CR>



" =========[ lspconfig ]======================================================

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

" Code for configuring lspconfig. 
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

let g:snipMate = { 'snippet_version' : 1 }

let g:UltiSnipsSnippetDirectories=["UltiSnips", "myUltiSnips"]




"lua <<EOF
"  local cmp = require'cmp'
"  cmp.setup({
"    snippet = {
"      expand = function(args)
"        vim.fn["vsnip#anonymous"](args.body)
"      end,
"    },
"    mapping = {
"      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
"    },
"    sources = {
"      { name = '...' },
"      ...
"    }
"  })
"EOF


" Settings for indent_blankline
" https://github.com/lukas-reineke/indent-blankline.nvim

" init.vim
"call plug#begin('~/.vim/plugged')
"Plug 'lukas-reineke/indent-blankline.nvim'
"call plug#end()
"
"lua <<EOF
"require("indent_blankline").setup {
"    char = "|",
"    buftype_exclude = {"terminal"}
"}
"EOF


" let g:indent_blankline_space_char = " "
" vim.opt.listchars = {
"     space = "⋅",
"     eol = "↴",
" }
"
" require("indent_blankline").setup {
"     show_end_of_line = true,
"     space_char_blankline = " ",
" }






" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position (tab stop).
"let g:UltiSnipsJumpForwardTrigger='<c-j>'

" shortcut to go to previous position (tab stop). Reverse tab should work.
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme


" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" Set the default python3
let g:python3_host_prog='/opt/local/bin/python3.9' 

" Install the python package unidecode to use deoplete.
let g:ycm_server_python_interpreter='/opt/local/bin/python3.9'


let g:citation_vim_bibtex_file="/Users/blaine/Google Drive/BibtexLibraries/global.bib"
let g:citation_vim_mode="bibtex"


let $FZF_BIBTEX_CACHEDIR = 'PATH-TO-CACHE-DIR'
let $FZF_BIBTEX_SOURCES = 'PATH-TO-BIBTEX-FILE'

function! s:bibtex_cite_sink(lines)
    let r=system("bibby-cite ", a:lines)
    execute ':normal! i' . r
endfunction

function! s:bibtex_markdown_sink(lines)
    let r=system("bibtex-markdown ", a:lines)
    execute ':normal! i' . r
endfunction

nnoremap <leader>c :call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_cite_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>

nnoremap <leader>m :call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_markdown_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Markdown> "'})<CR>

" <leader>c will bring up fzf to insert citation to selected items.
" <leader>m will bring up fzf to insert pretty markdown versions of selected items.
" An insert mode mapping, typing '@@' brings up fzf to insert a citation:
function! s:bibtex_cite_sink_insert(lines)
    let r=system("bibtex-cite ", a:lines)
    execute ':normal! i' . r
    call feedkeys('a', 'n')
endfunction

inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>


au BufEnter * call ncm2#enable_for_buffer()

" au User Ncm2Plugin call ncm2#register_source({
"             \ 'name' : 'vimtex',
"             \ 'priority': 1,
"             \ 'subscope_enable': 1,
"             \ 'complete_length': 1,
"             \ 'scope': ['tex'],
"             \ 'matcher': {'name': 'combine',
"             \           'matchers': [
"             \               {'name': 'abbrfuzzy', 'key': 'menu'},
"             \               {'name': 'prefix', 'key': 'word'},
"             \           ]},
"             \ 'mark': 'tex',
"             \ 'word_pattern': '\w+',
"             \ 'complete_pattern': g:vimtex#re#ncm,
"             \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"             \ })


" VimtexCompile: Start compiling the LaTex Code (in continuous mode since we set it above)
" VVimtexView: Open the compiled pdf using the
" VVimtexErrors: Display errors (if any) in the current file

" NCM2
augroup NCM2
  autocmd!
  " some other settings...
  " uncomment this block if you use vimtex for LaTex
  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END


set completeopt=noinsert,menuone,noselect

set noshowmode

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9, 
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })




let g:javascript_plugin_jsdoc           = 1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_return         = "⇚"

let g:jsx_ext_required = 0

let g:syntastic_check_on_open=1

map <C-E> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']

let g:ycm_autoclose_preview_window_after_completion=1

set foldmethod=indent
set foldlevel=99

au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

set guifont=Monaco:24 " set font size for firenvim. Helivetica and Arial do not work well. 24 seems to be upper limit.


" -------------------- LaTeX ---------------------------"

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_compiler_engine = 'lualatex'
let g:vimtex_compiler_progname = 'nvr'
" use SumatraPDF if you are on Windows
let g:vimtex_view_method = 'skim'

" Map F3 to counting the words in the detexed current tex document.
map <F3> :w !detex \| wc -w<CR>


function! VimFolds(lnum)
    " get content of current line and the line below
    let l:cur_line = getline(a:lnum)
    let l:next_line = getline(a:lnum+1)

    if l:cur_line =~# '^"{'
        return '>' . (matchend(l:cur_line, '"{*') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '"{*') - 1) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction


set foldmethod=expr
set foldexpr=VimFolds(v:lnum)


"=========[ Config vim-pomodoro ]======================
" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 25

" Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 5

" Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 0

" Path to the pomodoro log file (default: /tmp/pomodoro.log)
let g:pomodoro_log_file = "~/gtd/vim-pomodoro.log"

" To display the remaining time of a pomodoro in your statusline, add
set statusline=%#ErrorMsg#%{PomodoroStatus()}%#StatusLine#

" vim-pomodoro notification
let g:pomodoro_notification_cmd = 'zenity --notification --text="Pomodoro finished"'

" To play a soundfile after each completed pomodoro or break
let g:pomodoro_notification_cmd = "mpg123 -q ~/.config/nvim/ping.mp3"


"=================[ telescope ]===================================

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>




" i for insert from normal mode; ii for escape to normall mode
:inoremap ii  <Esc>

" for escape to normal mode
:inoremap <C-CR>  <Esc>