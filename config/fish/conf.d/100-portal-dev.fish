#!/usr/bin/env fish

# Homebrew
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# Mise (version manager)
if command -v mise &> /dev/null
    fish_add_path ~/.local/share/mise/shims
end

# AWS Configuration
set -gx AWS_PROFILE $USER
set -gx AWS_VAULT_BACKEND keychain
set -gx AWS_REGION us-east-1
