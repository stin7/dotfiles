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
stow -t ~ */
```

This symlinks all packages (`agents`, `tmux`, `zsh`) into your home directory. To stow individual packages:

```bash
stow -t ~ zsh tmux
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init --recursive
```

## Machine-specific config

Create `~/.zshrc.local` for anything that shouldn't be in the repo (work credentials, machine-specific paths, aliases, etc.). It's sourced automatically at the end of `.zshrc`.
