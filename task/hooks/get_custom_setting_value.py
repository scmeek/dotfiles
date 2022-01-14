#!/usr/bin/python3

# Retrieve a custom setting value from .taskrc (with a specific prefix).

import os
import sys
from numbers import Number
from typing import Union

from constants import CUSTOM_SETTING_PREFIX


def get_setting_value(
    setting_name: str, setting_prefix=CUSTOM_SETTING_PREFIX
) -> Union[str, bool, Number, None]:
    setting_key = setting_prefix + setting_name

    # Spaces help ensure the exact setting is retrieved
    # Can use rc.hooks=0 as an task argument but it shows the Configuration override message
    stream = os.popen(
        f'task show "{setting_key} " | grep "{setting_key} " | awk \'NR==1{{print tolower($2)}}\''
    )
    setting_value = stream.read().strip()

    if setting_value.lower() == "true":
        setting_value = True
    elif setting_value.lower() == "false":
        setting_value = False
    elif setting_value == "":
        setting_value = None
    elif setting_value.isdigit():
        setting_value = int(setting_value)

    return setting_value


def main():
    if len(sys.argv) != 2 and len(sys.argv) != 3:
        script_name = sys.argv[0]
        print(f"{script_name}: Only one or two arguments allowed", file=sys.stderr)
        exit(1)

    setting_name = sys.argv[1]

    if len(sys.argv) == 3:
        setting_prefix = sys.argv[2]
        return get_setting_value(setting_name, setting_prefix)

    return get_setting_value(setting_name)


if __name__ == "__main__":
    main()
