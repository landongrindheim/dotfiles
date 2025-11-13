#!/bin/sh

set -e

success() {
  echo "$(tput setaf 2)$*$(tput setaf 9) "
}

warning() {
  echo "$(tput setaf 3)$*$(tput setaf 9)"
}

error() {
  echo "$(tput setaf 1)$*$(tput setaf 9)"
}

symlink() {
  local origin=$1 destination=$2
  ln -s "$origin" "$destination"
  success "🔗 symlinking $destination"
}

install_fish_config() {
  # Create fish config directory
  mkdir -p "$HOME/.config/fish"

  # Symlink the fish configuration
  destination="$HOME/.config/fish"
  if [ -L "$destination" ]; then
    warning "⚠️  ~/.config/fish symlink already exists. Override? [y]es [n]o [q]uit"

    if [ "$CODESPACES" = "true" ]; then
      response="y"
    else
      read response
    fi

    case "$response" in
      Y | y )
        rm -rf "$destination"
        symlink "$(pwd -P)/config/fish" "$destination"
        ;;
      N | n )
        success "🆗 skipped fish config"
        ;;
      Q | q )
        error "☠️  exiting now ☠️"
        exit 0
        ;;
    esac
  elif [ -d "$destination" ]; then
    warning "⚠️  ~/.config/fish directory already exists. This will merge configurations."
    warning "Continue? [y]es [n]o [q]uit"

    if [ "$CODESPACES" = "true" ]; then
      response="y"
    else
      read response
    fi

    case "$response" in
      Y | y )
        # Copy files instead of symlinking for existing directory
        cp -r "$(pwd -P)/config/fish/"* "$destination/"
        success "📁 copied fish config files"
        ;;
      N | n )
        success "🆗 skipped fish config"
        ;;
      Q | q )
        error "☠️  exiting now ☠️"
        exit 0
        ;;
    esac
  else
    symlink "$(pwd -P)/config/fish" "$destination"
  fi
}

install_fish_shell() {
  # Install fish if not present
  if ! command -v fish > /dev/null; then
    if [ "$(uname)" = 'Darwin' ]; then
      brew install fish
    elif command -v apt-get > /dev/null; then
      sudo apt-get update
      sudo apt-get install -y fish
    else
      error "❌ Could not install fish. Please install it manually."
      exit 1
    fi
    success "🐟 fish shell installed"
  else
    success "🐟 fish shell already installed"
  fi

  # Add fish to /etc/shells if not already there
  if ! grep -q "$(command -v fish)" /etc/shells; then
    echo "$(command -v fish)" | sudo tee -a /etc/shells
    success "🐟 fish added to /etc/shells"
  fi

  # Optionally change default shell
  if [ "$SHELL" != "$(command -v fish)" ]; then
    warning "🐟 Would you like to make fish your default shell? [y]es [n]o"
    if [ "$CODESPACES" = "true" ]; then
      response="y"
    else
      read response
    fi

    case "$response" in
      Y | y )
        chsh -s "$(command -v fish)"
        success "🐟 default shell changed to fish"
        ;;
      N | n )
        success "🆗 keeping current shell"
        ;;
    esac
  fi
}

install_bass_if_needed() {
  # Bass is needed for NVM integration
  if command -v fish > /dev/null; then
    fish -c "
      if not functions -q bass
        echo 'Installing fisher package manager and bass...'
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install edc/bass
      else
        echo 'bass already installed'
      end
    " 2>/dev/null || {
      warning "⚠️  Could not install bass automatically."
      warning "To install bass for NVM support, run:"
      warning "  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source"
      warning "  fisher install edc/bass"
    }
  fi
}

success "🏗️ installing fish shell"
install_fish_shell

success "🏗️ installing fish configuration"
install_fish_config

success "🏗️ installing bass for bash compatibility"
install_bass_if_needed

success "🎉🎉🎉 fish setup complete 🎉🎉🎉"
success "Start a new terminal or run 'exec fish' to use fish shell"
