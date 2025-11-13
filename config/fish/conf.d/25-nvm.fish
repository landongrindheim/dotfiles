# NVM configuration
if test -z $XDG_CONFIG_HOME
    set -x NVM_DIR $HOME/.nvm
else
    set -x NVM_DIR $XDG_CONFIG_HOME/nvm
end

# Load nvm (only if bass is available)
if functions -q bass
    function nvm
        bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
    end

    # Auto-load .nvmrc if available
    function __check_nvm --on-variable PWD --description 'check nvm on directory change'
        status --is-command-substitution; and return
        if test -f .nvmrc; and command -v nvm > /dev/null
            nvm use
        end
    end
else
    echo "Note: bass not available, nvm integration disabled. Install with: fisher install edc/bass"
end