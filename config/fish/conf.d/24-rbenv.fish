# Rbenv configuration (only if mise is not installed)
if not command -v mise &>/dev/null
    fish_add_path $HOME/.rbenv/bin

    if command -v rbenv >/dev/null 2>&1
        rbenv init - fish | source
    end
end