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
    start=$(date +%s%N)
    zsh -i -c 'exit' >/dev/null 2>&1
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
    "name": "zsh startup time",
    "unit": "ms",
    "value": ${average}
  }
]
EOF
