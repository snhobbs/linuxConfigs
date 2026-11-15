export PATH=$HOME/.local/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:/usr/local/games
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/include
export PATH=$PATH:$HOME/.gem/ruby/3.2.0/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/local/go/bin
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:$HOME/go/bin
# export PATH=$PATH:/home/simon/ToolChains/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
#plugins+=(zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

#------------------------------------------////
## Colors:
##------------------------------------------////
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

#------------------------------------------////
## FUNCTIONS

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias eclipse="${HOME}/tools/eclipse/cpp-2019-06/eclipse/eclipse"
#alias eagle="${HOME}/tools/eagle-9.4.2/eagle"
#alias cmake="${HOME}/tools/cmake/bin/cmake"
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


export LANG=en_US.utf8
export LC_ALL=C.UTF-8

alias gits="git status"
alias gitd="git diff"
alias act="~/tools/act/bin/act"
#alias freecad="flatpak run --arch=x86_64 --file-forwarding org.freecad.FreeCAD"
#alias blender="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=blender --file-forwarding org.blender.Blender"

FREECAD_PYTHONPATH=${HOME}/.FreeCAD/squashfs-root/usr/lib/python3.11/site-packages
KICAD_PYTHONPATH=/usr/lib/kicad/lib/python3/dist-packages:/usr/lib/kicad/lib/x86_64-linux-gnu

[[ -e $HOME/.dircolors ]] && eval "`dircolors --sh $HOME/.dircolors`"

#export OPENSCADPATH=${OPENSCADPATH}:${HOME}/.local/share/OpenSCAD
#export PYTHONPATH=${PYTHONPATH}:${HOME}/tools/kicad-source-mirror/build/pcbnew/
#PCBNEW_DIR=/var/lib/flatpak/app/org.kicad.KiCad/x86_64/stable/2bf52c23c763b843e66b1ddd341ef62cd8c1d08dec056764a5a19a8c39c5e774/files/lib/python3.11/site-packages
PCBNEW_DIR=/usr/lib/python3/dist-packages
#export PYTHONPATH=${PYTHONPATH}:${PCBNEW_DIR}

alias gitsl="git status ./"
alias mcuxpresso="env SWT_GTK3=0 /usr/local/mcuxpressoide-24.12.148/ide/mcuxpressoide"
#export LD_LIBRARY_PATH=${HOME}/.local/lib/
#export PATH_TO_FREECAD_LIBDIR=${HOME}/.FreeCAD/squashfs-root/usr/lib/
alias pyserial-miniterm="python -m serial.tools.miniterm"

export PATH_TO_FREECAD_LIBDIR=${HOME}/.FreeCAD/squashfs-root/usr/lib/
setup_freecad() {
  source $HOME/enc/freecad
  export PYTHONPATH=${FREECAD_PYTHONPATH}:${PYTHONPATH}
}
alias vim=nvim


export ZEPHYR_SDK_INSTALL_DIR=~/.zephyr_ide/toolchains/zephyr-sdk-0.17.3

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

ta() {
    if [ -z "$TMUX" ]; then
        tmux attach || exec tmux new-session
        exit
    fi
}

#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /home/simon/envs/main/bin/activate
export KICAD_APPIMAGE=/home/simon/claude-workspace/kicad-10.0.6-x86_64-lite.AppImage




# ---- KiCad AppImage / pcbnew helpers ----
KICAD_APPIMAGE="${KICAD_APPIMAGE:-$HOME/claude-workspace/kicad-10.0.6-x86_64-lite.AppImage}"
# 1.6 GB when extracted. RAM/tmp re-extracts after reboot; use a disk path
# if you want it persistent.
KICAD_APPDIR="${KICAD_APPDIR:-${RAMDIR:-/tmp}/kicad-appimage/AppDir}"
_kicad_ensure() {
	if [[ ! -x "$KICAD_APPIMAGE" ]]; then
		printf 'kicad: AppImage not found: %s\n' "$KICAD_APPIMAGE" >&2
		return 1
	fi
	if [[ ! -x "$KICAD_APPDIR/bin/python3.11" || "$KICAD_APPIMAGE" -nt "$KICAD_APPDIR/.extracted" ]]; then
		local root
		root=$(dirname "$KICAD_APPDIR")
		printf 'kicad: extracting %s -> %s (1.6 GB, once)\n' "$KICAD_APPIMAGE" "$root" >&2
		mkdir -p "$root" || return 1
		rm -rf "$root/AppDir" "$root/squashfs-root"
		( cd "$root" && "$KICAD_APPIMAGE" --appimage-extract >/dev/null ) || return 1
		: > "$KICAD_APPDIR/.extracted"
	fi
}

# Create a uv venv backed by the AppImage's Python
kicad-uv-setup() {
	_kicad_ensure || return
	local venv="${1:-.venv}"
	if [[ -e "$venv" ]]; then
		printf 'kicad: %s already exists; remove it or choose another path\n' "$venv" >&2
		return 1
	fi
	uv venv --python "$KICAD_APPDIR/bin/python3.11" "$venv" || return
	printf 'kicad: created %s. Add packages with: uv add <pkg>\n' "$venv"
}


# Run a script / module / REPL with pcbnew. Uses ./.venv if it is a KiCad venv.
kicad-python() {
	_kicad_ensure || return
	local py="$KICAD_APPDIR/bin/python3.11"
	if [[ -x .venv/bin/python ]] && [[ "$(readlink -f .venv/bin/python)" == "$(readlink -f "$py")" ]]; then
		py=".venv/bin/python"
	fi
	"$py" "$@"
}



# Every IPv4 address on this machine, one per interface (skips loopback).
_local_ips() {
  if (( $+commands[ip] )); then   # Linux
    ip -4 -o addr show 2>/dev/null |
      awk '$2 != "lo" {sub("/.*", "", $4); printf "  %-16s %s\n", $2, $4}'
  else        # macOS / BSD
    ifconfig 2>/dev/null |
      awk '/^[^ \t]/ {iface = $1; sub(":$", "", iface)}
 /inet / && $2 != "127.0.0.1" {printf "  %-16s %s\n", iface, $2}'
  fi
}

# Running Docker containers and their IPs (silent if Docker isn't running).
_docker_ips() {
  (( $+commands[docker] )) || return
  local ids=$(docker ps -q 2>/dev/null)
  [[ -n $ids ]] || return
  print "Containers:"
  docker inspect -f '{{.Name}}{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' ${(f)ids} 2>/dev/null |
    awk '{n = $1; sub("^/", "", n); $1 = ""; printf "  %-16s%s\n", n, $0}'
}


SPLASH_ART=~/linuxConfigs/splash/snoopy.txt
SPLASH_ART_COLORS=(1-6:255 20-:9)     # rows 1–6 white, row 20 onward red
SPLASH_PAD=3      # gap between art and planes
SPLASH_SCARF=12-13   # Snoopy's scarf flutters
SPLASH_FILE=~/linuxConfigs/splash/splash.zsh


welcome() {
  source $SPLASH_FILE
  print
  figlet "Welcome, $USER"

  local d=$(( 10#$(date +%d) ))
  local -a cal=("${(@f)$(cal | awk -v d=$d '
    { line = " " substr(sprintf("%-22s", $0), 1, 22) " " }
    NR > 2 { sub(" " d " ", " \033[1;97;41m" d "\033[0m ", line) }
    { print substr(line, 2, length(line) - 2) }')}")
  local -a info=(
    "Today:  $(date '+%A %d %B, %H:%M')"
    "Up:     $(uptime -p | sed 's/^up //')"
    ""
    "IP addresses:"
    "${(@f)$(_local_ips)}"
  )
  local i
  for i in {1..$(( $#cal > $#info ? $#cal : $#info ))}; do
    print -r -- "  ${cal[i]:-${(l:22:)}}   ${info[i]}"
  done
}
welcome
