# Fish shell configuration

# Load all configuration modules
for config_file in ~/.config/fish/conf.d/*.fish
    source $config_file
end

# Silence macOS warning about bash
set -x BASH_SILENCE_DEPRECATION_WARNING 1