#!/usr/bin/python3

# The on-launch event is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

# This hook script loads any settings with the prefix "custom.sean."
#  as environment variables for downstream scripts.

import os
import subprocess
import sys
from typing import Optional

env_var_sync = "TASKWARRIOR_CUSTOM_SEAN_SYNC"


def main():
    script_name = sys.argv[0]

    sync = os.getenv(env_var_sync)

    if sync != f"{True}":
        # https://stackoverflow.com/questions/7389158/append-subprocess-popen-output-to-file
        # subprocess.run(["task", "synchronize", ">>", "~/.task/sync_hook.log"])
        pass

    print(f"{env_var_sync}: {sync}")


if __name__ == "__main__":
    main()
