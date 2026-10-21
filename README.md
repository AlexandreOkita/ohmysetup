# mysetup

A minimal, repeatable macOS setup powered by Homebrew and Oh My Zsh.

## Quick start

1. Clone this repository onto your Mac:

   ```bash
   git clone https://github.com/YOUR_USERNAME/mysetup.git
   cd mysetup
   ```

2. Run:

   ```bash
   bash setup.sh
   ```

The script installs Homebrew if necessary, installs all packages in `Brewfile`, and sets up Oh My Zsh. You may be prompted for your macOS password or Xcode Command Line Tools.

## What's included

- Spotify, Google Chrome, ChatGPT, VS Code, Ghostty
- Codex CLI and Claude Code CLI
- Git
- Oh My Zsh with the `git` plugin and `robbyrussell` theme

## Add more apps

Add `brew "package-name"` for command-line formulas or `cask "app-name"` for apps and CLI casks, then rerun `bash setup.sh`.

## Useful commands

```bash
brew bundle check --file=Brewfile     # Check what's missing
brew bundle --file=Brewfile           # Install missing packages
brew update && brew upgrade           # Update packages
```

## Notes

- The script is safe to rerun for already-installed packages and won't intentionally replace your `.zshrc`.
- If your `.zshrc` doesn't already source Oh My Zsh, the script appends a small Oh My Zsh configuration.
- Review the setup script before running it, as it downloads the official Homebrew and Oh My Zsh installers.
- Log in to your apps and AI CLIs manually after installation.
