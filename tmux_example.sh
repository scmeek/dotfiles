if ! tmux has-session -t yancy; then  # If session does not exist create it
	tmux new -s yancy -d  # Create a new session and detach
	tmux new-window -t yancy:2  # Create a new (second window)
	tmux split-window -t yancy:2 -v  # Split second window vertically
	tmux send-keys -t yancy:1 vim Enter  # Send vim command to first window
	tmux send-keys -t yancy:2.0 \
		morbo bin/yancy Enter  # Start yancy CMS in second window, first pane
	tmux send-keys -t yancy:2.1 \
		export TEST_YANCY_EXAMPLED=1 Enter  # Add env vars to second window, second pane
	tmux new-window -t yancy:3 \
		postgres -D perl/Yancy/db/pg  # Start new (third) window and start Postgres
	tmux split-window -t yancy:3 \
		mysqld --datadir=$HOME/db/mysql  # Split third window vertically and start mysql
fi
tmux attach -t yancy  # Attach if it exists

