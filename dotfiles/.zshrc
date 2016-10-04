if [[ ! -d ~/.zplug ]] then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

# Fish shell like syntax highlighting for Zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:19

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", nice:11

# Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-autosuggestions"

# Additional completion definitions for Zsh
zplug "zsh-users/zsh-completions", nice:-20

# An oh-my-zsh plugin to help remembering those aliases you defined once
zplug "djui/alias-tips"

# Easy setup of cdr for zsh
zplug "willghatch/zsh-cdr", nice:8

# zsh anything.el-like widget
zplug "zsh-users/zaw", nice:9

# Oh My Zsh plugin for Elixir, IEX, Mix and Phoenix
zplug "gusaiani/elixir-oh-my-zsh"

# A next-generation cd command with an interactive filter
# zplug "b4b4r07/enhancd", use:init.sh

# Little script to create, navigate and delete bookmarks in Bash and Zsh, using the fuzzy finder fzf
zplug "urbainvaes/fzf-marks"

# This is a repository of themes for GNU ls (configured via GNU dircolors) that support Ethan Schoonover’s Solarized color scheme
zplug "seebi/dircolors-solarized"

# oh-my-zsh stuff
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:-1
zplug "plugins/git", from:oh-my-zsh, nice:10
zplug "plugins/archlinux", from:oh-my-zsh, nice:10
zplug "plugins/npm", from:oh-my-zsh, nice:10
zplug "plugins/bower", from:oh-my-zsh, nice:10
zplug "plugins/docker", from:oh-my-zsh, nice:10
zplug "plugins/go", from:oh-my-zsh, nice:10
zplug "plugins/gradle", from:oh-my-zsh, nice:10
zplug "plugins/gulp", from:oh-my-zsh, nice:10
zplug "plugins/man", from:oh-my-zsh, nice:10
zplug "plugins/pip", from:oh-my-zsh, nice:10
zplug "plugins/vi-mode", from:oh-my-zsh, nice:10
zplug "plugins/golang", from:oh-my-zsh, nice:10
# zplug 'themes/sorin', from:oh-my-zsh, nice:11
# zplug "arialdomartini/oh-my-git", use:"*.sh"
# zplug "arialdomartini/oh-my-git-themes", use:"oppa-lana-style.zsh-theme"

# Theme
zplug "mafredri/zsh-async", nice:-1
zplug "sindresorhus/pure", nice:11

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

## enhancd
export ENHANCD_COMMAND="c"
##

## alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="vi"
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1
##

## zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
##

## zsh-history-substring-search
# If you use Mac, Fedora or Ubuntu
# check https://github.com/zsh-users/zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
##

## dircolors-solarized
eval $(dircolors "$ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-dark")
##

myZsh="$HOME/.zsh"
mkdir -p -m 700 "$myZsh"

## man zshoptions
setopt auto_menu
setopt no_menu_complete
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt list_packed
setopt no_list_beep
setopt correct
setopt correct_all
setopt hash_list_all
setopt complete_aliases
setopt interactive_comments

HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt share_history
setopt append_history
setopt inc_append_history
setopt extended_history
##

source "$myZsh/gnupg"
source "$myZsh/functions"
source "$myZsh/aliases"
source "$myZsh/grml"
source "$myZsh/fzf"
