#!/usr/bin/python3

# Call `task synchronize` with centralized sync logging. Call this script instead of `task synchronize` from scripts that sync.

import os
from datetime import datetime

from get_custom_setting_value import get_setting_value

# Note, do not include `sync` or `synchronize` as it is redundant.
TASKWARRIOR_COMMAND_SYNC_WHITELIST = [
    "command:add",
    "command:annotate",
    "command:append",
    "command:complete",
    "command:completed",
    "command:completed_last_week",
    "command:completed_last_week_annotated",
    "command:completed_within_last_week",
    "command:completed_within_last_week_annotated",
    "command:completed_last_yesterday",
    "command:completed_last_yesterday_annotated",
    "command:delete",
    "command:denotate",
    "command:done",
    "command:duplicate",
    "command:edit",
    "command:import",
    "command:list",
    "command:log",
    "command:ls",
    "command:mod",
    "command:modify",
    "command:newest",
    "command:next",
    "command:oldest",
    "command:overdue",
    "command:prepend",
    "command:projects",
    "command:purge",
    "command:ready",
    "command:recurring",
    "command:reports",
    "command:start",
    "command:stats",
    "command:stop",
    "command:summary",
    "command:tags",
    "command:unblocked",
    "command:undo",
    "command:waiting",
]
DATETIME_FORMAT = "%b %d %Y %I:%M:%S%p"  # Sep 14 2021 06:15:07PM


def task_sync():
    taskwarrior_directory = "~/.task/"
    sync_log_filename = get_setting_value("synchooklogfilename")
    last_sync_datetime_filename = get_setting_value("lastsyncdatetimefilename")

    sync_log_path = taskwarrior_directory + sync_log_filename
    last_sync_datetime_path = taskwarrior_directory + last_sync_datetime_filename

    now = datetime.now().strftime(DATETIME_FORMAT)
    os.system(f"echo {now} >> {sync_log_path}")
    exit_code = os.system(
        f"task synchronize >> {sync_log_path}"
    )  # Could use rc.hooks=0 but it adds extra output
    if exit_code == 0:
        os.system(f"echo {now} > {last_sync_datetime_path}")


if __name__ == "__main__":
    task_sync()
