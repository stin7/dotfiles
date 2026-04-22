# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

- `zsh`
- `fzf` (must be installed and on PATH)
- `git`
- `stow`

## Setup

```bash
git clone --recurse-submodules <your-repo-url> ~/dotfiles
cd ~/dotfiles
stow zsh
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init --recursive
```

## Machine-specific config

Create `~/.zshrc.local` for anything that shouldn't be in the repo (work credentials, machine-specific paths, aliases, etc.). It's sourced automatically at the end of `.zshrc`.

## What's included

### zsh

| File | Purpose |
|------|---------|
| `.zshrc` | Main config — completions, prompt, history, plugins |
| `.zsh/plugins/zsh-autosuggestions/` | Ghost-text history suggestions (git submodule) |
| `.zsh/plugins/fzf-dir.zsh` | Fuzzy directory jumping via `j <query>` |

## Key bindings

| Key | Action |
|-----|--------|
| `→` | Accept ghost suggestion |
| `Ctrl+R` | Fuzzy search history |
| `j foo` | Jump to a previously visited directory matching "foo" |
