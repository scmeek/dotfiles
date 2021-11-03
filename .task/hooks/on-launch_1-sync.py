#!/usr/bin/python3

# The on-launch event is triggered at launch, after the initialization
#  of all data structures, but before any processing. This event
#  provides an opportunity to prevent launch.

# This hook script syncs on-launch if it hasn't run today.

import os
import sys
from datetime import datetime

from constants import (
    DATETIME_FORMAT,
    SETTING_NAME_SYNC,
    TASKWARRIOR_COMMAND_SYNC_WHITELIST,
    TASKWARRIOR_DIRECTORY_EXPANDED,
)
from get_custom_setting_value import get_setting_value
from sync import task_sync


def main():
    taskwarrior_command = sys.argv[3]
    if not taskwarrior_command in TASKWARRIOR_COMMAND_SYNC_WHITELIST:
        return

    sync = get_setting_value(SETTING_NAME_SYNC)
    if not sync:
        return

    sync_onlaunch_only_if_havent_today = True
    if sync_onlaunch_only_if_havent_today:
        last_sync_datetime_filename = get_setting_value("lastsyncdatetimefilename")
        last_sync_datetime_path = (
            TASKWARRIOR_DIRECTORY_EXPANDED + last_sync_datetime_filename
        )

        if os.path.isfile(last_sync_datetime_path):
            last_sync_datetime_raw = ""
            with open(last_sync_datetime_path, "r") as last_sync_datetime_file:
                last_sync_datetime_raw = last_sync_datetime_file.readline().strip()

            if (
                last_sync_datetime_raw is not None
                and last_sync_datetime_raw.strip() != ""
            ):
                last_sync_datetime = datetime.strptime(
                    last_sync_datetime_raw, DATETIME_FORMAT
                )
                this_morning_6am = datetime.now().replace(
                    hour=6, minute=0, second=0, microsecond=0
                )
                if (
                    last_sync_datetime.time() > this_morning_6am.time()
                    and last_sync_datetime.date() <= datetime.now().date()
                ):
                    return

    task_sync()


if __name__ == "__main__":
    main()
