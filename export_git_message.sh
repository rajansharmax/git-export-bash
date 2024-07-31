#!/bin/bash

# Enable path auto-completion
shopt -s direxpand

# Prompt the user to enter the path to the Git repository with tab completion
echo "Enter the path to your Git repository:"
read -e REPO_PATH

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

# Create output file in the same directory as the script
OUTPUT_FILE="$PWD/commit_messages_formatted.txt"
> "$OUTPUT_FILE"

# Construct git log command based on provided inputs
if [ -z "$AUTHOR" ]; then
    # If AUTHOR is empty (blank), retrieve commit messages from all authors
    git log --pretty=format:"%ad - %an <%ae> - %s" --date=iso --since="$START_DATE" --until="$END_DATE" > temp_commits.txt
else
    # If AUTHOR is not empty, retrieve commit messages from the specified author within the date range
    git log --pretty=format:"%ad - %an <%ae> - %s" --date=iso --since="$START_DATE" --until="$END_DATE" --author="$AUTHOR" > temp_commits.txt
fi

# Ensure temp_commits.txt is not empty
if [ ! -s temp_commits.txt ]; then
    echo "No commits found in the specified date range and/or author."
    rm temp_commits.txt
    exit 1
fi

# Process commits to group by date and author, and sort by date
awk -F' - ' '
{
    date = substr($1, 1, 10);
    author = $2 " " $3;
    commit = $4;
    key = date " " author;
    if (!(key in counts)) {
        counts[key] = 0;
    }
    counts[key]++;
    commits[key] = commits[key] "\n" counts[key] ". " commit;
    dates[date]++;
}
END {
    PROCINFO["sorted_in"] = "@ind_str_asc";
    for (date in dates) {
        for (key in counts) {
            if (index(key, date) == 1) {
                split(key, arr, " ");
                date = arr[1];
                author = substr(key, index(key, " ") + 1);
                print date " " author >> "'$OUTPUT_FILE'";
                print commits[key] >> "'$OUTPUT_FILE'";
                print "" >> "'$OUTPUT_FILE'"; # Add an empty line between different dates/authors
            }
        }
    }
}
' temp_commits.txt

# Remove temporary file
rm temp_commits.txt

echo "Exported Git commit messages within specified date range to $OUTPUT_FILE"
