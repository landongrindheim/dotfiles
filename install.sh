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
  success "🔗 symlinking ~/.$origin"
}

install_dotfiles() {
  for symlinkable in [[:lower:]]*; do
    destination="$HOME/.${symlinkable}"
    if [ -f "$destination" -o -d "$destination" -o -L "$destination" ]; then
      warning "⚠️  ~/$(basename $destination) already exists. Override? [y]es [n]o [q]uit"

      read -n 1 response

      case "$response" in
        Y | y )
          rm -rf "$destination"
          symlink "$(pwd -P)/$symlinkable" "$destination"
          ;;
        N | n )
          success "🆗"
          continue
          ;;
        Q | q )
          error "☠️  exiting now ☠️"
          exit 0
          ;;
      esac
    else
      symlink "$symlinkable" "$destination"
    fi
  done
}

success "🏗️ symlinking dotfiles"
install_dotfiles

success "🎉🎉🎉 all done 🎉🎉🎉"
success "Make sure to run 'source ~/.bashrc'"
