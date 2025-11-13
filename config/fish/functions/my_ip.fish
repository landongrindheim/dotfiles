#!/usr/bin/env fish

# lifted verbatim from @jasonrudolph
# https://github.com/jasonrudolph/dotfiles/blob/master/bin/ipecho

function my_ip
    curl http://whatismyip.akamai.com
    echo
end