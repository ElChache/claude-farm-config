#!/bin/bash

# Agent Grid Launcher - All 11 agents in one tmux session
SESSION_NAME="agent_grid"
PROJECT_PATH="/Users/davidcerezo/Projects/monitors"

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

echo "🌐 Launching Agent Grid (11 agents in split view)..."

# Create new session with first agent
tmux new-session -d -s $SESSION_NAME -n "Agent Grid" -c "$PROJECT_PATH"

# Split into grid layout - 4 rows x 3 columns (with some merged)
# Top row - Leadership (Opus)
tmux split-window -h -c "$PROJECT_PATH"  # Split horizontally 
tmux split-window -h -c "$PROJECT_PATH"  # Split again

# Second row - Core Dev (Sonnet) 
tmux select-pane -t 0
tmux split-window -v -c "$PROJECT_PATH"  # Split vertically from pane 0
tmux split-window -h -c "$PROJECT_PATH"  # Split horizontally
tmux split-window -h -c "$PROJECT_PATH"  # Split again

# Third row - Specialists Part 1 (Haiku)
tmux select-pane -t 3
tmux split-window -v -c "$PROJECT_PATH"  # Split vertically 
tmux split-window -h -c "$PROJECT_PATH"  # Split horizontally
tmux split-window -h -c "$PROJECT_PATH"  # Split again

# Fourth row - Specialists Part 2 (Haiku)
tmux select-pane -t 6
tmux split-window -v -c "$PROJECT_PATH"  # Split vertically
tmux split-window -h -c "$PROJECT_PATH"  # Split horizontally

echo "⚙️ Setting up agent environments..."

# Set up aliases for each pane with appropriate models
# Leadership Team (Opus) - Panes 0,1,2
tmux send-keys -t $SESSION_NAME:0.0 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model opus --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.1 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model opus --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.2 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model opus --dangerously-skip-permissions"' C-m

# Core Dev Team (Sonnet) - Panes 3,4,5
tmux send-keys -t $SESSION_NAME:0.3 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.4 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.5 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model sonnet --dangerously-skip-permissions"' C-m

# Specialist Team (Haiku) - Panes 6,7,8,9,10
tmux send-keys -t $SESSION_NAME:0.6 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.7 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.8 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.9 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m
tmux send-keys -t $SESSION_NAME:0.10 'alias cc="ENABLE_BACKGROUND_TASKS=1 claude --model haiku --dangerously-skip-permissions"' C-m

# Wait for aliases to be set
sleep 3

# Launch Claude Code in all panes
echo "🚀 Starting all Claude instances..."
for i in {0..10}; do
    tmux send-keys -t $SESSION_NAME:0.$i 'cc' C-m
    sleep 1
done

# Wait for Claude Code to load
echo "⏳ Waiting for Claude Code to initialize (15 seconds)..."
sleep 15

# Send startup prompts to all agents
echo "📝 Sending startup instructions..."
STARTUP_PROMPT=$(cat $PROJECT_PATH/coordination/agent_startup_prompt.md)

for i in {0..10}; do
    tmux send-keys -t $SESSION_NAME:0.$i "$STARTUP_PROMPT" C-m
    sleep 2
done

# Add pane titles
tmux select-pane -t 0 -T "Product Manager (Opus)"
tmux select-pane -t 1 -T "System Architect (Opus)" 
tmux select-pane -t 2 -T "Lead Developer (Opus)"
tmux select-pane -t 3 -T "Backend Dev 1 (Sonnet)"
tmux select-pane -t 4 -T "Backend Dev 2 (Sonnet)"
tmux select-pane -t 5 -T "AI Developer (Sonnet)"
tmux select-pane -t 6 -T "Frontend Dev 1 (Haiku)"
tmux select-pane -t 7 -T "Frontend Dev 2 (Haiku)"
tmux select-pane -t 8 -T "Technical QA (Haiku)"
tmux select-pane -t 9 -T "UX Expert (Haiku)"
tmux select-pane -t 10 -T "Graphic Designer (Haiku)"

# Enable pane titles
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_title}"

echo "✅ Agent Grid launched successfully!"
echo "💡 View with: tmux attach -t agent_grid"
echo "📊 Navigate: Ctrl+b then arrow keys to switch panes"
echo "🔍 Zoom pane: Ctrl+b, z (toggle)"

# Attach to the session
echo "🔗 Attaching to session..."
tmux attach-session -t $SESSION_NAME