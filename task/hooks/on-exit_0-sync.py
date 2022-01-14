#!/usr/bin/python3

# This event is triggered after all processing, but
# 	immediately before output is displayed, which is
# 	the last opportunity to contribute footnotes/errors.
# 	This event has no opportunity to modify tasks.

# This hook script syncs on-exit if there are changes.

import sys

from constants import SETTING_NAME_SYNC
from get_custom_setting_value import get_setting_value
from sync import task_sync


def main():
    modified_tasks_raw = sys.stdin.readline().strip()
    if modified_tasks_raw != "":
        sync = get_setting_value(SETTING_NAME_SYNC)
        if sync:
            task_sync()


if __name__ == "__main__":
    main()
