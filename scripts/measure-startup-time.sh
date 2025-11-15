#!/bin/bash
set -euo pipefail

# Number of runs for averaging
RUNS=10

echo "Measuring zsh startup time (${RUNS} runs)..." >&2

# Array to store times
declare -a times

# Run zsh startup multiple times
for i in $(seq 1 $RUNS); do
    # Measure startup time using date command (more portable)
    # Set TMUX to skip auto-start, but load all rc files and plugins
    start=$(date +%s%N)
    # Capture both stdout and stderr to see any errors
    if ! env TMUX=benchmark zsh -i -c 'exit' 2>&1 | grep -v "command not found" >/dev/null; then
        echo "Warning: zsh startup had some issues, but continuing..." >&2
    fi
    end=$(date +%s%N)
    
    # Calculate time in milliseconds
    time_ms=$(echo "scale=2; ($end - $start) / 1000000" | bc)
    
    times+=($time_ms)
    echo "Run $i: ${time_ms}ms" >&2
done

# Calculate average
total=0
for time in "${times[@]}"; do
    total=$(echo "$total + $time" | bc)
done
average=$(echo "scale=2; $total / $RUNS" | bc)

echo "Average: ${average}ms" >&2

# Output in benchmark-action format (custom)
cat << EOF
[
  {
    "name": "zsh startup time (with plugins)",
    "unit": "ms",
    "value": ${average}
  }
]
EOF
