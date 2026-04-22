_fzf_dir_log="$HOME/.zsh_dir_history"

_log_dir() {
  grep -v "^${PWD}$" "$_fzf_dir_log" 2>/dev/null | tail -999 > "$_fzf_dir_log.tmp"
  echo "$PWD" >> "$_fzf_dir_log.tmp"
  mv "$_fzf_dir_log.tmp" "$_fzf_dir_log"
}

chpwd() { _log_dir }

j() {
  local dir
  dir=$(tac "$_fzf_dir_log" 2>/dev/null | fzf --query="$*" --select-1 --exit-0) && cd "$dir"
}