#!/usr/bin/env bash

set -e

DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

warning() {
  echo -e "\033[0;33m$1\033[0m" # Yellow text for warnings
}

success() {
  echo -e "\033[0;32m$1\033[0m" # Green text for success
}

install_fish_shell() {
  echo "🏗️ Installing fish shell..."
  if command -v fish >/dev/null 2>&1; then
    echo "🐟 fish shell already installed"
  else
    warning "⚠️ fish shell not found. Please install it via Homebrew: brew install fish"
    exit 1
  fi
}

setup_fish_config() {
  echo "🏗️ Installing fish configuration"
  CONFIG_DIR="$HOME/.config/fish"

  # Check if the desired target directory for the symlink already exists
  if [[ -L "$CONFIG_DIR" ]]; then
      echo "🆗 ~/.config/fish symlink already exists and points to $CONFIG_DIR"
  elif [[ -d "$CONFIG_DIR" ]]; then
      warning "⚠️ ~/.config/fish directory already exists (not a symlink)."
      read -r -p "Override and replace with symlink? [y/N/q] " choice
      choice=${choice:-n}
      case "$choice" in
          y|Y)
              rm -rf "$CONFIG_DIR"
              ln -s "$DOTFILES_ROOT/fish" "$CONFIG_DIR"
              success "✅ Symlinked $CONFIG_DIR to $DOTFILES_ROOT/fish"
              ;;
          *)
              echo "🆗 skipped fish config setup."
              ;;
      esac
  else
      ln -s "$DOTFILES_ROOT/fish" "$CONFIG_DIR"
      success "✅ Symlinked $CONFIG_DIR to $DOTFILES_ROOT/fish"
  fi
}

install_fisher_plugin_manager() {
  echo "🏗️ Installing Fisher plugin manager"

  # 1. Check if Fisher is available in the current shell environment
  if command -v fish >/dev/null 2>&1 && fish -c "functions -q fisher" >/dev/null 2>&1; then
      echo "🐟 Fisher already installed (function available in fish)."
      return
  fi

  # 2. Install Fisher persistently. This *must* be done inside fish -c
  if command -v fish >/dev/null 2>&1; then
      # This command installs Fisher and makes it persistent across sessions
      fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
      success "✅ Fisher installed."
  else
      warning "⚠️ Cannot install Fisher: fish shell not found."
  fi
}

install_fish_plugins() {
  echo "🏗️ Installing Fish plugins from fish_plugins manifest"

  if command -v fish >/dev/null 2>&1 && fish -c "functions -q fisher" >/dev/null 2>&1; then
    # This command reads the fish_plugins file and installs/updates all listed plugins
    fish -c "fisher update"
    success "✅ Fish plugins installed/updated."
  else
    warning "⚠️ Cannot install plugins: Fisher is not available."
  fi
}

install_fish_shell
setup_fish_config
install_fisher_plugin_manager
install_fish_plugins

success "🎉🎉🎉 Fish setup complete 🎉🎉🎉"
echo "Note: To use the new settings, start a new terminal or run 'exec fish'."
