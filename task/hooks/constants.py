#!/usr/bin/python3

from pathlib import Path

TASK_DATA_DIR_SIMPLE = "~/.task/data"
TASK_DATA_DIR_EXPANDED = (
    str(Path(TASK_DATA_DIR_SIMPLE).expanduser()) + "/"
)

DATETIME_FORMAT = "%b %d %Y %I:%M:%S%p"  # Sep 14 2021 06:15:07PM
CUSTOM_SETTING_PREFIX = "custom.sean."
SETTING_NAME_SYNC = "sync"

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
    "command:news",
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
