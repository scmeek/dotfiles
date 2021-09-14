#!/bin/sh
# This hooks script syncs task warrior to the configured task server.
# The on-launch is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

exit 0

echo "launch sync"

# If already processing, ignore (task calls itself during normal operation).
if [ -n "$TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING" ] && [ "$TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING" -eq 1 ]; then
	echo "bail"
	exit 0
fi

export TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING=1

echo "launch TASKWARRIOR_CUSTOM_SEAN_SYNC:"
echo $TASKWARRIOR_CUSTOM_SEAN_SYNC

if [[ -n "$TASKWARRIOR_CUSTOM_SEAN_SYNC" ]]; then
	echo "Syncing..."
	task synchronize >> ~/.task/sync_hook.log
fi

unset TASKWARRIOR_ON_LAUNCH_HOOK_SYNC_PROCESSING

exit 0
