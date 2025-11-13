#!/usr/bin/env fish

# I've had issues with video being hijacked by different programs. This has
# become a problem, particularly with Zoom. This command resets video

function reset_video
    sudo killall VDCAssistant
end