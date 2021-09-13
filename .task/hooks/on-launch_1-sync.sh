#!/bin/sh
# This hooks script syncs task warrior to the configured task server.
# The on-exit event is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

# Make sure hooks are enabled

# Prevent infinite loop (`task` is called to retrieve a setting below)
if [ -n "$TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING" ] && [ "$TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING" -eq 1 ]; then
    exit 0
fi

export TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING=1

# Use custom setting, 'custom.sync' to enable syncing
sync=$( task show custom.sync | grep custom.sync | awk 'NR==1{print tolower($2)}' )

if [ $sync = "true" ]; then
    export TASKWARRIOR_CUSTOM_SYNC=1 # Used by other hooks
else
    unset TASKWARRIOR_CUSTOM_SYNC
fi

if [ $sync = "true" ]; then
    echo "Syncing..."
    task sync >> ~/.task/sync_hook.log
    echo "Done"
fi

unset TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING

exit 0
