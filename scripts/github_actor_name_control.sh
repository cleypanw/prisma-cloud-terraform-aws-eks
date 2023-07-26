#!/bin/bash

# Check if a github_actor is provided as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <github_actor>"
  exit 1
fi

actor="$1"

# Remove underscores and convert to lowercase
new_actor=$(echo "$actor" | tr '_' '-' | tr '[:upper:]' '[:lower:]')

# Limit the actor name to 10 characters
new_actor="${new_actor:0:10}"

# Print the modified filename
echo "$new_actor"
