#!/bin/bash

# Specialist Team Launcher - 5 agents with Claude Haiku (Fast Specialized Execution)
SESSION_NAME="specialist_agents"
PROJECT_PATH="/Users/davidcerezo/Projects/monitors"

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

echo "🎨 Launching Specialist Team (5 agents with Claude Haiku - Fast Execution)..."

# Create new session with first agent
tmux new-session -d -s $SESSION_NAME -c "$PROJECT_PATH"

# Split into 5 panes in grid layout
tmux split-window -h -c "$PROJECT_PATH"    # Split horizontally
tmux split-window -v -c "$PROJECT_PATH"    # Split right pane vertically
tmux select-pane -t 0
tmux split-window -v -c "$PROJECT_PATH"    # Split left pane vertically
tmux select-pane -t 2
tmux split-window -h -c "$PROJECT_PATH"    # Split bottom right horizontally

echo "⚙️ Setting up specialist environments..."

# Set up each pane with Claude Haiku
tmux send-keys -t $SESSION_NAME:0.0 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.1 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.2 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.3 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.4 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m

# Wait for aliases to be set
sleep 2

# Launch Claude Code in each pane
echo "🚀 Starting Claude Haiku instances..."
tmux send-keys -t $SESSION_NAME:0.0 'cc' C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.1 'cc' C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.2 'cc' C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.3 'cc' C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.4 'cc' C-m

# Wait for Claude Code to load
echo "⏳ Waiting for Claude Code to initialize (6 seconds)..."
sleep 6

# Send startup prompts to each agent
echo "📝 Sending startup instructions..."
STARTUP_PROMPT=$(cat $PROJECT_PATH/coordination/agent_startup_prompt.md)

tmux send-keys -t $SESSION_NAME:0.0 "$STARTUP_PROMPT" C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.1 "$STARTUP_PROMPT" C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.2 "$STARTUP_PROMPT" C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.3 "$STARTUP_PROMPT" C-m
sleep 1
tmux send-keys -t $SESSION_NAME:0.4 "$STARTUP_PROMPT" C-m

# Add pane titles
tmux select-pane -t 0 -T "Frontend Dev 1 (Haiku)"
tmux select-pane -t 1 -T "Frontend Dev 2 (Haiku)"
tmux select-pane -t 2 -T "Technical QA (Haiku)"
tmux select-pane -t 3 -T "UX Expert (Haiku)"
tmux select-pane -t 4 -T "Graphic Designer (Haiku)"

# Enable pane titles
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_title}"

echo "✅ Specialist Team (Haiku) launched successfully!"
echo "💡 View with: tmux attach -t specialist_agents" 
echo "📊 Navigate: Ctrl+b then arrow keys to switch panes"
echo "🔍 Zoom pane: Ctrl+b, z (toggle)"

# Attach to the session
echo "🔗 Attaching to session..."
tmux attach-session -t $SESSION_NAME