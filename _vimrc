let mapleader = ','

source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Показывать номера строк
set relativenumber
" Включить подсветку синтаксиса
syntax on
" Поиск в процессе набора
set incsearch
" Подсвечивание результатов поиска
set hlsearch
" умная зависимость от регистра. Детали `:h smartcase`
set ignorecase
set smartcase
" Кодировка текста по умолчанию utf8
set termencoding=utf-8
" Включаем несовместимость настроек с Vi, так как Vi нам и не понадобится
set nocompatible
" Показывать положение курсора всё время.
set ruler
" Показывать незавершённые команды в статусбаре
set showcmd
" Фолдинг по отсупам
set foldenable
set foldlevel=100
set foldmethod=indent
" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden
" Скрыть панель в gui версии
set guioptions-=T
set guioptions-=m
" Включить автоотступы
set autoindent
" Не переносить строки
set nowrap
" Преобразование Таба в пробелы
set expandtab
" Размер табуляции по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4
" Включаем "умные" отступы, например, авто отступ после `{`
set smartindent
" Отображение парных символов
set showmatch
" Навигация с учетом русских символов, учитывается командами следующее/предыдущее слово и т.п.
set iskeyword=@,48-57,_,192-255
" Удаление символов бэкспэйсом в Windows
set backspace=indent,eol,start
" Подсвечивать линию текста, на которой находится курсор
set cursorline
highlight CursorLine guibg=lightblue ctermbg=lightgray
highlight CursorLine term=none cterm=none
" Увеличение размера истории
set history=200
" Дополнительная информация в строке состояния
set wildmenu
" Включение сторонних плагинов
filetype plugin on

set backupdir-=.
set backupdir^=~/vimtmp
set noundofile
set fenc=utf-8
set termencoding=utf-8

colorscheme adventurous
colorscheme holokai
colorscheme colibri
colorscheme monokai-soda
colorscheme pink
colorscheme strawberry-light
colorscheme strawberry-dark

inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
command M w|mak|!a
