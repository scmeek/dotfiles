#!/usr/bin/python3

# Call `task synchronize` with centralized sync logging.
#   Call this script instead of `task synchronize` from
#   scripts that sync.

import os
from datetime import datetime

from constants import DATETIME_FORMAT, TASKWARRIOR_DIRECTORY_EXPANDED
from get_custom_setting_value import get_setting_value


def task_sync():
    sync_log_filename = get_setting_value("synchooklogfilename")
    last_sync_datetime_filename = get_setting_value("lastsyncdatetimefilename")

    sync_log_path = TASKWARRIOR_DIRECTORY_EXPANDED + sync_log_filename
    last_sync_datetime_path = (
        TASKWARRIOR_DIRECTORY_EXPANDED + last_sync_datetime_filename
    )

    now = datetime.now().strftime(DATETIME_FORMAT)
    os.system(f"echo {now} >> {sync_log_path}")
    exit_code = os.system(
        f"task synchronize >> {sync_log_path}"  # Could use rc.hooks=0 but it adds extra output
    )
    if exit_code == 0:
        os.system(f"echo {now} > {last_sync_datetime_path}")


if __name__ == "__main__":
    task_sync()
