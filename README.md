# dotfiles

## Goal

Consistent terminal UX across Mac and Linux machines to support use cases including:

- Knowing which host the current terminal is on with hostname indicators in `zsh` and `tmux`
- Managing agents with indicators on idle `tmux` windows that need attention
- Folder navigation with `fzf-tab`
- Repeat common commands with autocomplete

## Requirements

- `zsh`
- `fzf`
- `git`
- `stow`

## Setup

```bash
git clone --recurse-submodules https://github.com/stin7/dotfiles ~/dotfiles
cd ~/dotfiles
stow -t ~ */
```

This symlinks all packages into the home directory. To stow individual packages:

```bash
stow -t ~ zsh tmux
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init --recursive
```

## Machine-specific config

Create `~/.zshrc.local` for anything that shouldn't be in the repo (work credentials, machine-specific paths, aliases, etc.). It's sourced automatically at the end of `.zshrc`.
