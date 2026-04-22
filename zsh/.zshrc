# --- Completion ---
autoload -Uz compinit
setopt EXTENDED_GLOB
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
unsetopt EXTENDED_GLOB

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# --- fzf-tab (must be after compinit) ---
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree -C -L 2 $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview '[[ -d $realpath ]] && ls --color=always $realpath || cat $realpath 2>/dev/null | head -50'
zstyle ':fzf-tab:complete:*:argument-rest' fzf-preview 'ps -p $word -o command= 2>/dev/null'

# --- Autosuggestions ---
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# --- Prompt (nord) ---
# nord7 #8FBCBB·109  nord8 #88C0D0·110  nord9 #81A1C1·109  nord10 #5E81AC·67
# nord11 #BF616A·131  nord12 #D08770·173  nord13 #EBCB8B·222
# nord14 #A3BE8C·144  nord15 #B48EAD·139  nord3 #4C566A·240
autoload -Uz vcs_info
autoload -U colors && colors
setopt PROMPT_SUBST

precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats       ' %F{222}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{222}%b%f %F{131}(%a)%f'

# Hostname -> consistent-but-distinct color (no per-host config needed)
_nord_host_color() {
  local palette=(109 110 144 139 173)   # nord7 nord8 nord14 nord15 nord12
  local h=$(hostname | cksum | awk '{print $1}')
  echo ${palette[$(( h % ${#palette[@]} + 1 ))]}
}
NORD_HOST=$(_nord_host_color)

PROMPT='%F{$NORD_HOST}%n@%m%f %F{240}%~%f${vcs_info_msg_0_}
%(?.%F{144}.%F{131})❯%f '

# --- fzf ---
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# --- Dir jumping ---
source ~/.zsh/plugins/fzf-dir.zsh

# --- Syntax highlighting styles (must be before sourcing the plugin) ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=144'        # nord14 green
ZSH_HIGHLIGHT_STYLES[builtin]='fg=144'
ZSH_HIGHLIGHT_STYLES[function]='fg=110'       # nord8 frost
ZSH_HIGHLIGHT_STYLES[alias]='fg=110'
ZSH_HIGHLIGHT_STYLES[path]='fg=default'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=131'  # nord11 red
ZSH_HIGHLIGHT_STYLES[comment]='fg=240'        # nord3

# --- Syntax highlighting (must be last plugin) ---
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- fzf theme (nord) ---
export FZF_DEFAULT_OPTS="
  --color=fg:-1,bg:-1,hl:110
  --color=fg+:15,bg+:238,hl+:110
  --color=info:240,prompt:144,pointer:131
  --color=marker:222,spinner:139,header:240
  --color=border:240
"

# --- Exports ---
export PI_CODING_AGENT_DIR="$HOME/.agents"

# --- Local overrides ---
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
