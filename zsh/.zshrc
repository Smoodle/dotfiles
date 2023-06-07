#pfetch

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/home/smoodle/.local/bin:$PATH

if [ -d /var/lib/flatpak/exports/bin ]; then
  export PATH=/var/lib/flatpak/exports/bin:$PATH
fi

export ANDROID_HOME=/opt/android-sdk/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:/home/smoodle/.scripts

setopt rmstarsilent
# Path to your oh-my-zsh installation.
export ZSH="/home/smoodle/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="juanghurtado"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#export BROWSER=firefox
export EDITOR="nvim"                  # $EDITOR opens in terminal

setopt HIST_IGNORE_SPACE

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi

alias gpg-recv="gpg --keyserver keyserver.ubuntu.com --recv-key"

alias ssh='TERM=xterm-256color ssh'


#Tmux alias
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"

#Gallery-dl
alias gldl="gallery-dl -d /Media/gallery-dl"
alias gp="gldl --chapter-range 1-25 "
alias gh="gp --cookies /Media/gallery-dl/cookies.txt -o user-agent='Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/113.0'"

#General alias
alias sudo="sudo "
alias start-vline="sbcl --load ~/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp"
#alias emacs="emacsclient -c -a 'emacs'"
alias v=nvim
alias vim=nvim
alias pencil="electron11 /usr/lib/pencil"

alias redshift="redshift -l 38.7172303:-9.1235584"

alias remote="node ~/Media/Programming/SimplePCController/server/src/controller.js"

alias luamake=/home/smoodle/.builds/lua-language-server/3rd/luamake/luamake

alias skyrim_run="DXVK_FRAME_RATE=60 STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.steam/root/ STEAM_COMPAT_DATA_PATH=/Games/SteamLibrary/steamapps/compatdata/489830/ gamemoderun gamescope -w 1920 -h 1080 -W 2560 -H 1440 -f -U ~/.steam/root/compatibilitytools.d/GE-Proton7-45/proton run"

#alias skyrim_mo="DXVK_FRAME_RATE=60 STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.steam/root/ STEAM_COMPAT_DATA_PATH=/Games/SteamLibrary/steamapps/compatdata/489830/ gamemoderun gamescope -w 1920 -h 1080 -W 2560 -H 1440 -f -U ~/.steam/root/compatibilitytools.d/GE-Proton7-45/proton run /Games/SteamLibrary/steamapps/compatdata/489830/pfx/drive_c/Modding/MO2/ModOrganizer.exe"
alias skyrim_mo="DXVK_FRAME_RATE=60 STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.steam/root/ STEAM_COMPAT_DATA_PATH=/Games/SteamLibrary/steamapps/compatdata/489830/ gamescope -w 1280 -h 720 -W 2560 -H 1440 -b -U mangohud gamemoderun ~/.steam/root/compatibilitytools.d/GE-Proton7-45/proton run /Games/SteamLibrary/steamapps/compatdata/489830/pfx/drive_c/Modding/MO2/ModOrganizer.exe"

alias genshin_pulls="cat /Games/Genshin/Game/GenshinImpact_Data/webCaches/Cache/Cache_Data/data_2 | grep -a 'e20190909gacha-v2'"

alias devCast="NODE_ENV='development' node index.js"

function pomo() {
    arg1=$1
    shift
    args="$*"

    min=${arg1:?Example: pomo 15 Take a break}
    sec=$((min * 60))
    msg="${args:?Example: pomo 15 Take a break}"

    while true; do
        date '+%H:%M' && sleep "${sec:?}" && notify-send -u critical -t 0 -a pomo "${msg:?}"
    done
}
