" __     ___           
" \ \   / (_)_ __ ___  
"  \ \ / /| | '_ ` _ \ 
"   \ V / | | | | | | |
"    \_/  |_|_| |_| |_|
"   ____             __ _                       _   _             
"  / ___|___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __  
" | |   / _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \ 
" | |__| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
"  \____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
"                         |___/                                   

" Load Vim plugins
source ~/.config/nvim/plugins.vim

" Plugin configs
for configfile in split(globpath("~/.config/nvim/plugin-settings", "*.vim"), '\n') 
    execute('source '.configfile)
endfor

" Load binds
source ~/.config/nvim/maps.vim

" Load general settings
source ~/.config/nvim/settings.vim

" Load theme
source ~/.config/nvim/theme.vim
