set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
source ~/linuxConfigs/.vimrc

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

set shiftwidth=2
set tabstop=2
"let g:clang_format#style_options = {
"            \ "BasedOnStyle" : "Google",
"            \ "SpacesBeforeTrailingComments" : 2,
"            \ "Standard" : "C++17"}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
