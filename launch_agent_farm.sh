#!/bin/bash

# Agent Farm Launcher - 11 Agent Grid Layout
SESSION_NAME="agent_farm"

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session with first window
tmux new-session -d -s $SESSION_NAME -n "Product Owner"

# Create additional windows for each role
tmux new-window -t $SESSION_NAME -n "System Architect"
tmux new-window -t $SESSION_NAME -n "Lead Developer" 
tmux new-window -t $SESSION_NAME -n "UX Expert"
tmux new-window -t $SESSION_NAME -n "Graphic Designer"
tmux new-window -t $SESSION_NAME -n "Backend Dev 1"
tmux new-window -t $SESSION_NAME -n "Backend Dev 2"
tmux new-window -t $SESSION_NAME -n "Frontend Dev 1"
tmux new-window -t $SESSION_NAME -n "Frontend Dev 2"
tmux new-window -t $SESSION_NAME -n "AI Developer"
tmux new-window -t $SESSION_NAME -n "QA Tester"

# Set up each window with Claude Code command
tmux send-keys -t $SESSION_NAME:"Product Owner" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"System Architect" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Lead Developer" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"UX Expert" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Graphic Designer" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Backend Dev 1" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Backend Dev 2" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Frontend Dev 1" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"Frontend Dev 2" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"AI Developer" 'cc' C-m
tmux send-keys -t $SESSION_NAME:"QA Tester" 'cc' C-m

# Wait for Claude Code to load
sleep 5

# Send startup prompts from file
tmux send-keys -t $SESSION_NAME:"Product Owner" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"System Architect" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Lead Developer" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"UX Expert" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Graphic Designer" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Backend Dev 1" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Backend Dev 2" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Frontend Dev 1" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"Frontend Dev 2" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"AI Developer" "$(cat coordination/agent_startup_prompt.md)" C-m
tmux send-keys -t $SESSION_NAME:"QA Tester" "$(cat coordination/agent_startup_prompt.md)" C-m

# Attach to the session
tmux attach-session -t $SESSION_NAME