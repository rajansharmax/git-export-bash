#!/bin/bash

# Prompt the user to enter the path to the Git repository
echo "Enter the path to your Git repository:"
read REPO_PATH

# Check if the specified directory exists
if [ ! -d "$REPO_PATH" ]; then
    echo "Error: Directory not found."
    exit 1
fi

# Navigate to the repository directory
cd "$REPO_PATH" || exit

# Prompt the user to enter the start date (YYYY-MM-DD)
echo "Enter the start date (YYYY-MM-DD):"
read START_DATE

# Prompt the user to enter the end date (YYYY-MM-DD)
echo "Enter the end date (YYYY-MM-DD):"
read END_DATE

# Prompt the user to enter the author's name or email address (leave blank for all authors)
echo "Enter the author's name or email address (leave blank for all authors):"
read AUTHOR

# Construct git log command based on provided inputs
if [ -z "$AUTHOR" ]; then
    # If AUTHOR is empty (blank), retrieve commit messages from all authors
    git log --pretty=format:"%ad %s" --date=iso --since="$START_DATE" --until="$END_DATE" > all_commit_messages_within_dates.txt
else
    # If AUTHOR is not empty, retrieve commit messages from the specified author within the date range
    git log --pretty=format:"%ad %s" --date=iso --since="$START_DATE" --until="$END_DATE" --author="$AUTHOR" > commit_messages_by_author_within_dates.txt
fi

echo "Exported Git commit messages within specified date range to output file."
