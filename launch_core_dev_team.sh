#!/bin/bash

# Core Development Team Launcher - 3 agents with Claude Sonnet (Complex Implementation)
SESSION_NAME="core_dev_agents"
PROJECT_PATH="/Users/davidcerezo/Projects/monitors"

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

echo "👨‍💻 Launching Core Dev Team (3 agents with Claude Sonnet - Complex Implementation)..."

# Create new session with first agent
tmux new-session -d -s $SESSION_NAME -c "$PROJECT_PATH"

# Split into 3 panes in grid layout
tmux split-window -h -c "$PROJECT_PATH"    # Split horizontally
tmux split-window -v -c "$PROJECT_PATH"    # Split right pane vertically

echo "⚙️ Setting up core development environments..."

# Set up each pane with Claude Sonnet
tmux send-keys -t $SESSION_NAME:0.0 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.1 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.2 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m

# Wait for aliases to be set
sleep 2

# Launch Claude Code in each pane
echo "🚀 Starting Claude Sonnet instances..."
tmux send-keys -t $SESSION_NAME:0.0 'cc' C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 'cc' C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 'cc' C-m

# Wait for Claude Code to load
echo "⏳ Waiting for Claude Code to initialize (8 seconds)..."
sleep 8

# Send startup prompts to each agent
echo "📝 Sending startup instructions..."
STARTUP_PROMPT=$(cat $PROJECT_PATH/coordination/agent_startup_prompt.md)

tmux send-keys -t $SESSION_NAME:0.0 "$STARTUP_PROMPT" C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 "$STARTUP_PROMPT" C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 "$STARTUP_PROMPT" C-m

# Add pane titles
tmux select-pane -t 0 -T "Backend Dev 1 (Sonnet)"
tmux select-pane -t 1 -T "Backend Dev 2 (Sonnet)"
tmux select-pane -t 2 -T "AI Developer (Sonnet)"

# Enable pane titles
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_title}"

echo "✅ Core Dev Team (Sonnet) launched successfully!"
echo "💡 View with: tmux attach -t core_dev_agents" 
echo "📊 Navigate: Ctrl+b then arrow keys to switch panes"
echo "🔍 Zoom pane: Ctrl+b, z (toggle)"

# Attach to the session
echo "🔗 Attaching to session..."
tmux attach-session -t $SESSION_NAME