#!/usr/bin/env fish

# I've been having a LOT of issues with my audio input/output
# being hijacked by different programs. This command resets audio

function reset_sound
    sudo killall coreaudiod
end