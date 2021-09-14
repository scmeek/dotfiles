#!/bin/sh
# This hooks script syncs task warrior to the configured task server.
# The on-launch event is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

echo "custom config"

# Prevent infinite loop (`task` is called to retrieve a setting below)
if [ -n "$TASKWARRIOR_ON_LAUNCH_HOOK_CUSTOM_CONFIG" ] && [ "$TASKWARRIOR_ON_LAUNCH_HOOK_CUSTOM_CONFIG" -eq 1 ]; then
	echo "custom config bail"
	exit 0
fi

function get_value {
	if [[ "$#" -ne "1" ]]; then
		echo "$0: invalid get_value() call signature" >&2
		exit 1
	fi
	value=$( task show $1 | grep $1 | awk 'NR==1{print tolower($2)}' )
	echo $value
}

# $1 = key, $2 = val 
function empty {
	val_empty=0 # 0=false, assume not empty
	if [[ "$#" -eq "1" || -z "$2" ]]; then # Expected 2 arguments and got one (val empty), or argument 2 is empty
		echo "$0: expected setting not defined ('$1')" >&2
		val_empty=1
	fi
	echo $val_empty
}

# $1 = env_var, $2 = val
function export_env_var {
	if [[ "$#" -ne "2" ]]; then
		echo "$0: invalid export_env_var() call signature" >&2
		exit 1
	fi

	# Any translation / validation would go here. Possibly make a .json file with definitions a valid values.

	export $1=$2
	export TASKWARRIOR_CUSTOM_SEAN_SYNC=true
}

export TASKWARRIOR_ON_LAUNCH_HOOK_CUSTOM_CONFIG=1

echo "keys get"

# Keys and env. variables
key_sync="custom.sean.sync"
env_key_sync="TASKWARRIOR_CUSTOM_SEAN_SYNC"

# Retrieval
sync=$(get_value $key_sync)

echo "keys empty test"

# Empty test
expected_settings_empty+=$(empty $key_sync $sync)

echo "keys fail if empty"

# Fail if any expected settings are empty
if [[ $expected_settings_empty -ne 0 ]]; then
	exit 1
fi

echo "export section"

# Export to environment variable(s)
export_env_var $env_key_sync $sync
export $env_key_sync=$sync
echo "setting TASK_WARRIOR_CUSTOM_SEAN_SYNC"
export TASK_WARRIOR_CUSTOM_SEAN_SYNC=1
echo $TASKWARRIOR_CUSTOM_SEAN_SYNC

unset TASKWARRIOR_ON_LAUNCH_HOOK_CUSTOM_CONFIG

exit 0
