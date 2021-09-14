#!/usr/bin/python3

# The on-launch event is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

# This hook script loads any settings with the prefix "custom.sean."
#  as environment variables for downstream scripts.

import os
import sys
from typing import Optional

custom_setting_prefix = "custom.sean."
env_var_prefix = "TASKWARRIOR_CUSTOM_SEAN_"


def get_value(key: str) -> Optional[str]:
    stream = os.popen(
        f"task show {key} | grep {key} | awk 'NR==1{{print tolower($2)}}'"
    )
    value = stream.read().strip()
    if value.lower() == "true":
        value = f"{True}"
    if value == "":
        value = None
    return value


def main():
    script_name = sys.argv[0]

    # Prevent infinite loop (`task` is called to retrieve a setting below)
    prevent_loop_env_var = "TASKWARRIOR_ON_LAUNCH_HOOK_1_CUSTOM_CONFIG"
    prevent_loop_env_var_val = f"{True}"
    already_processing = os.getenv(prevent_loop_env_var)
    if already_processing:
        exit()
    os.environ[prevent_loop_env_var] = prevent_loop_env_var_val

    # Keys and env. variables
    name_sync = "sync"
    key_sync = custom_setting_prefix + name_sync
    env_key_sync = env_var_prefix + name_sync.upper()

    # Retrieval
    settings = {}
    settings[key_sync] = get_value(key_sync)

    # Empty test
    if None in settings.values():
        none_settings = {k for (k, v) in settings.items() if v is None}
        print(f"{script_name}: One or more expected settings missing: {none_settings}")
        exit(1)

    # Export to environment variable(s)
    os.environ[env_key_sync] = settings[key_sync]

    del os.environ[prevent_loop_env_var]


if __name__ == "__main__":
    main()
