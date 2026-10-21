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

- Spotify, Steam, Google Chrome, ChatGPT, VS Code, Ghostty
- Codex CLI and Claude Code CLI
- Git
- Oh My Zsh with the `git` plugin and `robbyrussell` theme

## Add more apps

Add `brew "package-name"` for command-line formulas or `cask "app-name"` for apps and CLI casks, then rerun `bash setup.sh`.

## AI coding CLIs

`Brewfile` includes the `codex` and `claude-code` casks. Running `bash setup.sh` installs both and skips any CLI already available in your PATH or managed by Homebrew.

After setup, open a new terminal and check the installations:

```bash
codex --version
claude --version
```

Run `codex` or `claude` and follow the sign-in prompts. See the official [Codex CLI documentation](https://learn.chatgpt.com/docs/codex/cli) and [Claude Code installation guide](https://code.claude.com/docs/en/setup).

## Change the Oh My Zsh theme

A fresh Oh My Zsh configuration uses `robbyrussell`. If you already have a `~/.zshrc`, setup preserves it, including your existing theme.

Open `~/.zshrc` and change the `ZSH_THEME` assignment before the line that sources Oh My Zsh. For example, to use the bundled `bira` theme:

```zsh
ZSH_THEME="bira"
# ...
source "$ZSH/oh-my-zsh.sh"
```

Reload the configuration from a Zsh terminal:

```zsh
source ~/.zshrc
```

Browse the bundled options in the [Oh My Zsh theme gallery](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes). External themes require separate installation.

## Useful commands

```bash
brew bundle check --file=Brewfile     # Check what's missing
brew bundle --file=Brewfile           # Install missing packages
brew update && brew upgrade           # Update packages
```

## Notes

- The script is safe to rerun for already-installed packages and won't intentionally replace your `.zshrc`.
- If your existing `.zshrc` doesn't source Oh My Zsh, add `export ZSH="$HOME/.oh-my-zsh"`, your `ZSH_THEME` setting, `plugins=(git)`, and `source "$ZSH/oh-my-zsh.sh"` in that order.
- Review the setup script before running it, as it downloads the official Homebrew and Oh My Zsh installers.
- Log in to your apps and AI CLIs manually after installation.
