#!/usr/bin/python3

# This on-launch event is triggered at launch, after the initialization
#   of all data strcutures, but before any processing. This event
#   provides an opportunity to prevent launch.

# This hook scrypt checks the API version as other hooks depend on v2.
#   While it's unlikely taskwarrior will make breaking changes, it's still worth validating.

# Example invoke of script from API v2:
# $ ~/.task/hooks/on-xxx.yyy \
#   api:2 \
#   args:'task rc:~/mytaskrc list' \
#   command: add \
#   rc:/home/foo/mytaskrc \
#   data:/home/foo/.task \
#   version:2.4.3 \
#   <input.txt \
#   >output.txt

import sys


def main():
    script_name = sys.argv[0]
    api_version_argument = sys.argv[1]

    if api_version_argument != "api:2":
        print(
            f"{script_name}: Hooks API isn't v2. Functionality may have changed.",
            file=sys.stderr,
        )
        # Intentionally not failing
        # exit(1)


if __name__ == "__main__":
    main()
