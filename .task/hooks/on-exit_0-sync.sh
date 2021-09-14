#!/bin/sh
# This hooks script syncs task warrior to the configured task server.
# The on-exit event is triggered once, after all processing is complete.

# Make sure hooks are enabled

# Count the number of tasks modified
n=0
while read modified_task
do
	n=$(($n + 1))
done

if [ -n "$TASKWARRIOR_CUSTOM_SEAN_SYNC" ] && ["$TASKWARRIOR_CUSTOM_SEAN_SYNC" == "true" ]; then
	if (($n > 0)); then
		task synchronize >> ~/.task/sync_hook.log
	fi
fi

exit 0
