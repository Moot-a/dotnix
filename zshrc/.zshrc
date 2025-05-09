# === History ===
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY CORRECT

# === Better up/down search ===
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# === Oh My Zsh ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git common-aliases sudo)

source $ZSH/oh-my-zsh.sh

# === Aliases ===
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -lha"
alias gs="git status"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"

# === zoxide ===
eval "$(zoxide init zsh)"

# === Completion ===
autoload -Uz compinit
compinit

# === Syntax Highlighting ===
# Make sure this is installed and sourced after compinit
source /path/to/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# === Autosuggestions ===
# Make sure this is installed and sourced after syntax highlighting
source /path/to/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

eval "$(starship init zsh)"