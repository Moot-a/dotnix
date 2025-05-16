# === History ===
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS APPEND_HISTORY \
       INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY CORRECT

# === Oh My Zsh bootstrap ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"        # ← comment out if you stick with starship

# Plugins managed by OMZ (cloned into $ZSH_CUSTOM/plugins/)
plugins=(
  git
  common-aliases
  sudo
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Autosuggestions tweaks – must come *before* oh-my-zsh.sh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

source "$ZSH/oh-my-zsh.sh"

# === Better ↑ / ↓ history search ===
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# === Aliases ===
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias gs='git status'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'

# === zoxide ===
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# === Starship prompt ===
# Comment this out if you prefer the robbyrussell OMZ theme
eval "$(starship init zsh)"
