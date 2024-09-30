import os
import subprocess
from datetime import datetime
from collections import defaultdict

# Function to validate if a date string is in the correct format and represents a valid date
def is_valid_date(date_str):
    try:
        datetime.strptime(date_str, "%Y-%m-%d")
        return True
    except ValueError:
        return False

# Function to get user input with validation
def get_input(prompt, required=True, validate=None):
    while True:
        user_input = input(prompt).strip()
        if not user_input and not required:
            return ''
        if validate and not validate(user_input):
            print("Invalid input. Please try again.")
        else:
            return user_input

def main():
    # Prompt the user to enter the path to the Git repository
    repo_path = get_input("Enter the path to your Git repository: ", validate=os.path.isdir)
    
    # Navigate to the repository directory
    os.chdir(repo_path)
    
    # Prompt the user to enter the start date and end date
    start_date = get_input("Enter the start date (YYYY-MM-DD): ", validate=is_valid_date)
    end_date = get_input("Enter the end date (YYYY-MM-DD): ", validate=is_valid_date)
    
    # Prompt the user to enter the author's name or email address
    author = get_input("Enter the author's name or email address (leave blank for all authors): ", required=False)
    
    # Output file path
    output_file = os.path.join(repo_path, 'commit_messages_formatted.txt')
    
    # Construct git log command based on provided inputs
    git_command = [
        'git', 'log',
        f'--pretty=format:%ad - %an <%ae> - %s',
        f'--date=short',  # Change date format to YYYY-MM-DD
        f'--since={start_date}',
        f'--until={end_date}'
    ]
    
    if author:
        git_command.append(f'--author={author}')
    
    # Run the git command and capture the output
    try:
        result = subprocess.run(git_command, check=True, text=True, capture_output=True)
        commits = result.stdout.strip().split('\n')
    except subprocess.CalledProcessError:
        print("Error: Unable to retrieve commits.")
        return
    
    if not commits:
        print("No commits found in the specified date range and/or author.")
        return
    
    # Process commits to group by date and author
    commit_data = defaultdict(lambda: defaultdict(list))
    for commit in commits:
        try:
            date, author_and_email, message = commit.split(' - ', 2)
            author, email = author_and_email.split(' <', 1)
            email = email.strip('>')
        except ValueError:
            continue
        
        commit_data[date][(author, email)].append(message)
    
    # Write to output file
    with open(output_file, 'w') as file:
        for date, authors in sorted(commit_data.items()):
            for (author, email), messages in sorted(authors.items()):
                file.write(f"{date} {author} <{email}>\n")
                for i, message in enumerate(messages, start=1):
                    file.write(f"{' '}. {message}\n")
                file.write("\n")  # Add an empty line between different authors within the same date
    
    print(f"Exported Git commit messages within specified date range to {output_file}")

if __name__ == "__main__":
    main()
