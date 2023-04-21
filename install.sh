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

      if [ "$CODESPACES" = "true" ]; then
        response="y"
      else
        read response
      fi

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
      symlink "$(pwd -P)/$symlinkable" "$destination"
    fi
  done
}

install_packages() {
  if [ "$(uname)" = 'Darwin' ]; then
    if [ -n "$(command -v brew 2> /dev/null)" ]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  elif [ "$CODESPACES" = "true" ]; then
    if [ -n "$(command -v brew 2> /dev/null)" ]; then
      curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
      /bin/bash < /tmp/install_homebrew.sh
      (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "$HOME/.profile"
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  fi

  brew bundle
}

configure_vim() {
  if [ ! -d vim/autoload/plug.vim ];then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  # open Vim, install plugins, then close Vim (exit Vim-Plug window, then Vim)
  vim +PlugInstall +Copilot_setup +exit +exit
}

success "🏗️ symlinking dotfiles"
install_dotfiles

success "🏗️ installing packages"
install_packages

success "🏗️ configuring Vim"
configure_vim

success "🎉🎉🎉 all done 🎉🎉🎉"
success "Make sure to run 'source ~/.bashrc'"
