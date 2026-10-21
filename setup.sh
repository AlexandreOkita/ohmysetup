#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$ROOT_DIR/Brewfile"

log() { printf '\n==> %s\n' "$*"; }

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This setup is intended for macOS." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon: /opt/homebrew; Intel: /usr/local
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Persist Homebrew in PATH for future login shells (without duplicating it).
BREW_SHELLENV="eval \"$($(command -v brew) --prefix)/bin/brew shellenv\""
touch "$HOME/.zprofile"
if ! grep -Fqx "$BREW_SHELLENV" "$HOME/.zprofile"; then
  printf '\n%s\n' "$BREW_SHELLENV" >> "$HOME/.zprofile"
fi

# Applications installed outside Homebrew are left untouched.
app_for_cask() {
  case "$1" in
    spotify) echo 'Spotify.app' ;;
    google-chrome) echo 'Google Chrome.app' ;;
    chatgpt) echo 'ChatGPT.app' ;;
    visual-studio-code) echo 'Visual Studio Code.app' ;;
    ghostty) echo 'Ghostty.app' ;;
    *) return 1 ;;
  esac
}

command_for_cask() {
  case "$1" in
    codex) echo 'codex' ;;
    claude-code) echo 'claude' ;;
    *) return 1 ;;
  esac
}

already_present() {
  local cask="$1" app binary
  if brew list --cask "$cask" >/dev/null 2>&1; then
    return 0
  fi
  if app="$(app_for_cask "$cask")"; then
    [[ -d "/Applications/$app" || -d "$HOME/Applications/$app" ]] && return 0
  fi
  if binary="$(command_for_cask "$cask")"; then
    command -v "$binary" >/dev/null 2>&1 && return 0
  fi
  return 1
}

log 'Installing packages from Brewfile'
while IFS= read -r line || [[ -n "$line" ]]; do
  # The supported Brewfile format is: brew "name" or cask "name".
  if [[ "$line" =~ ^[[:space:]]*brew[[:space:]]+\"([a-zA-Z0-9@+._-]+)\" ]]; then
    name="${BASH_REMATCH[1]}"
    if brew list --formula "$name" >/dev/null 2>&1; then
      echo "Skipping formula $name (already managed by Homebrew)"
    else
      brew install "$name"
    fi
  elif [[ "$line" =~ ^[[:space:]]*cask[[:space:]]+\"([a-zA-Z0-9@+._-]+)\" ]]; then
    name="${BASH_REMATCH[1]}"
    if already_present "$name"; then
      echo "Skipping cask $name (already installed)"
    else
      brew install --cask "$name"
    fi
  fi
done < "$BREWFILE"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  log 'Skipping Oh My Zsh (already installed)'
else
  log 'Installing Oh My Zsh'
  # Prevent installer from changing the shell or launching zsh mid-script.
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

log 'Finished! Restart your terminal to load the new configuration.'
