local zplug_dir="$HOME/.zplug/repos/zplug/zplug"

if [[ ! -d ~/.zplug ]] then
    git clone https://github.com/zplug/zplug $zplug_dir
    source $zplug_dir/init.zsh && zplug update --self
fi

source $zplug_dir/init.zsh

# A next-generation plugin manager for zsh
zplug "zplug/zplug"

# Fish shell like syntax highlighting for Zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:18

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", nice:19

# Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-autosuggestions"

# Additional completion definitions for Zsh
zplug "zsh-users/zsh-completions"

# An oh-my-zsh plugin to help remembering those aliases you defined once
zplug "djui/alias-tips"

# Easy setup of cdr for zsh
zplug "willghatch/zsh-cdr", nice:5

# zsh anything.el-like widget
zplug "zsh-users/zaw", nice:6

# Oh My Zsh plugin for Elixir, IEX, Mix and Phoenix
zplug "gusaiani/elixir-oh-my-zsh"

# Little script to create, navigate and delete bookmarks in Bash and Zsh, using the fuzzy finder fzf
zplug "urbainvaes/fzf-marks"

# This is a repository of themes for GNU ls (configured via GNU dircolors) that support Ethan Schoonover’s Solarized color scheme
zplug "seebi/dircolors-solarized"

# A modified version of oh-my-zsh's plugin colored-man-pages, optimized for solarized dark theme in terminal
zplug "zlsun/solarized-man"

# Docker completion
zplug "docker/docker", use:"contrib/completion/zsh/_docker"

# Docker-compose completion
zplug "docker/compose", use:"compose/contrib/completion/zsh/_docker-compose"

# Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v
export CACHE_DIR="${HOME}/.cache"
[[ ! -d "${CACHE_DIR}" ]] && mkdir -p "${CACHE_DIR}"
fasd_cache="${CACHE_DIR}/fasd-init-cache"
zplug clvv/fasd, \
      as:command, \
      hook-build:"./fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $fasd_cache", nice:17

# oh-my-zsh stuff
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:-1
zplug "plugins/docker-compose", from:oh-my-zsh, use:"docker-compose.plugin.zsh"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/bower", from:oh-my-zsh
zplug "plugins/gradle", from:oh-my-zsh
zplug "plugins/gulp", from:oh-my-zsh
zplug "plugins/man", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/gb", from:oh-my-zsh
zplug "plugins/postgres", from:oh-my-zsh
zplug "plugins/rsync", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/grep", from:oh-my-zsh
zplug "plugins/systemd", from:oh-my-zsh

# Theme
# zplug "aranasaurus/zemm-blinks.zsh-theme"
zplug "themes/blinks", from:oh-my-zsh
# zplug "themes/sorin", from:oh-my-zsh
# zplug "mafredri/zsh-async", nice:-2
# zplug "sindresorhus/pure"
# zplug "molovo/filthy"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

## fasd
source "$fasd_cache"
unset fasd_cache

## alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="vi"
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1
##

## zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
# bind ctrl+space to accept current suggestion
bindkey '^ ' autosuggest-accept
##

## zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
##

## zsh-history-substring-search
# If you use Mac, Fedora or Ubuntu
# check https://github.com/zsh-users/zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
##

## plugin/sudo
# Alt + s
bindkey "^[s" sudo-command-line
##

## vim command mode mapping ##
# Alt + a
bindkey -M viins '^[a' vi-cmd-mode
##

## dircolors-solarized
eval $(dircolors "$ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-dark")
##

myZsh="$HOME/.zsh"
mkdir -p -m 700 "$myZsh"

# Shift tab to complement tab in menu completion
bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete

## man zshoptions
# setopt extended_glob
setopt print_exit_value
setopt brace_ccl
setopt no_menu_complete
setopt auto_list
setopt auto_menu
setopt list_packed
# setopt list_rows_first
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt list_packed
setopt no_list_beep
setopt no_beep
setopt correct
setopt hash_list_all
setopt complete_aliases
setopt interactive_comments
setopt long_list_jobs

export HISTIGNORE='&:sudo rm *:rm *'
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt no_share_history
setopt no_inc_append_history
setopt append_history
setopt extended_history
##

source "$myZsh/gnupg"
source "$myZsh/functions"
source "$myZsh/aliases"
source "$myZsh/grml"
source "$myZsh/fzf"

# Because robbyrussell/oh-my-zsh/lib/misc.zsh overrides the one in .zprofile
export LESS=' -x4RFsXmgiJ '
