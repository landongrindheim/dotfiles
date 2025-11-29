# Fish shell configuration

# Load all configuration modules
for config_file in ~/.config/fish/conf.d/*.fish
    source $config_file
end
