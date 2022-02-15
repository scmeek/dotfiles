#!/bin/bash
# This hooks script syncs task warrior to the configured task server.
# The on-exit event is triggered once, after all processing is complete.

# Let's do a quick check. If the taskw command already is synchronize, we
# wouldn't need to run this script
for arg in $*; do
  if [[ "$arg" == api:* ]]; then
    IFS=':'
    read -ra api_level <<< "$arg"
    api_level=${api_level[1]}
    case $api_level in
      1|2) ;;
      *) echo "Sync hook - unsupported API level '$api_level'"
        exit -1 ;;
    esac
  fi
  if [[ "$arg" == command:synchronize ]]; then
    exit 0
  fi
done

TMUX_SESSION_TOKEN="_taskwarrior-sync"
SYNC_DELAY=10
TASKW_HOOK_TMP_DIR="$HOME/.task/data/.tmp"
TASKW_IS_DIRTY_FILE="$TASKW_HOOK_TMP_DIR/sync_dirty.data"

mkdir -p "$TASKW_HOOK_TMP_DIR"

# The logic is as following:
# 1. only continue the script if something was modified in this session,
#    or something in previous session has not been synced.
# 2. spawn a tmux session to run in background (non-blocking)
# 3. within the session, sleep to create delays, allow user to *undo*
#    or add more data.
# 4. when that happens, and when this script is called again, kill
#    the previous existing session, and the new session will starts
#    from 1. again.
# 5  if it succeed, it will empty the is_dirty file.
# 6. if it fails, the taskw will remained to be dirty and will tries
#    to perform sync the next time.

# Count the number of tasks modified
n=0
while read modified_task
do
  n=$(($n + 1))
done

# If file exists and it's non-empty
is_dirty=$(test -e "$TASKW_IS_DIRTY_FILE" && cat $TASKW_IS_DIRTY_FILE)

if [[ ! $is_dirty && (($n -eq 0)) ]]; then
  exit 0
fi

# Kill existing session, if exists
tmux kill-session -t "$TMUX_SESSION_TOKEN" 2>/dev/null
# Mark taskwarrior sync as dirty
echo 1 > "$TASKW_IS_DIRTY_FILE"

# SYNC IN BACKGROUND.
# tmux also prevent duplicated session
tmux new -d -s "$TMUX_SESSION_TOKEN" "sleep '${SYNC_DELAY}' \
  && date >> ~/.task/data/auto-sync.log \
  && task sync >> ~/.task/data/auto-sync.log 2>&1 \
  && echo '------------\n' >> ~/.task/data/auto-sync.log \
  && terminal-notifier -message 'Taskwarrior sync successful' \
  && rm ${TASKW_IS_DIRTY_FILE} \
  || terminal-notifier -message 'Taskwarrior sync failed'"
  echo "Sync in ${SYNC_DELAY}s"

exit 0

