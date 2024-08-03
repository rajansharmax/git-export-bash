# Git Commit Export Tool

Welcome to the Git Commit Export Tool! This utility allows you to export Git commits based on date filters, user email, and username.

## Features

- **Export Commits by Date Range**: Retrieve commits within a specified date range.
- **Export Commits by User Email**: Filter commits based on the email address of the author.
- **Export Commits by Username**: Filter commits based on the username of the author.

## Installation

To use this tool, follow these steps:

1. Clone the repository:

   git clone https://github.com/rajansharmax/git-export-bash.git

2. Navigate to the project directory:

   cd git-export-bash

3. Ensure the script is executable:

   chmod +x git-commit-export.sh

4. Run the script:

   bash git-commit-export.sh

## Usage

### Export Commits by Date Range

To export commits within a specific date range, run the script and follow the prompts:

bash git-commit-export.sh

You will be prompted to enter the path to your Git repository, the start date, and the end date. Optionally, you can provide an author's name or email address to filter the commits further.

#### Sample Output

Enter the path to your Git repository: /path/to/your/repo
Enter the start date (YYYY-MM-DD): 2023-01-01
Enter the end date (YYYY-MM-DD): 2023-12-31
Enter the author's name or email address (leave blank for all authors):

Exported Git commit messages within the specified date range to /path/to/your/repo/commit_messages_formatted.txt

### Export Commits by User Email

To filter commits by a specific user's email, provide the email address when prompted:

bash git-commit-export.sh

Enter the path to your Git repository: /path/to/your/repo
Enter the start date (YYYY-MM-DD): 2023-01-01
Enter the end date (YYYY-MM-DD): 2023-12-31
Enter the author's name or email address (leave blank for all authors): user@example.com

Exported Git commit messages within the specified date range to /path/to/your/repo/commit_messages_formatted.txt

### Export Commits by Username

Similarly, to filter commits by a specific username, provide the username when prompted:

bash git-commit-export.sh

Enter the path to your Git repository: /path/to/your/repo
Enter the start date (YYYY-MM-DD): 2023-01-01
Enter the end date (YYYY-MM-DD): 2023-12-31
Enter the author's name or email address (leave blank for all authors): username

Exported Git commit messages within the specified date range to /path/to/your/repo/commit_messages_formatted.txt

## Sample Output File

Below is an example of how the exported commit messages will be formatted in the output file (commit_messages_formatted.txt):

2023-01-01 John Doe <john.doe@example.com>
1. Fixed typo in documentation
2. Improved performance of data processing algorithm

2023-01-02 Jane Smith <jane.smith@example.com>
1. Added new feature to user dashboard
2. Refactored authentication module

2023-01-03 John Doe <john.doe@example.com>
1. Updated dependencies to latest versions
2. Fixed bug in payment processing

## Advantages

- **Efficiency**: Quickly export commit messages without manually sifting through Git logs.
- **Customization**: Filter commits by date, email, or username to focus on relevant changes.
- **Automation**: Integrate this tool into your workflow for automated reporting and analysis.

With the Git Commit Export Tool, managing and analyzing your Git commit history becomes easier and more efficient. Start using it today to streamline your development process!

---

Developed by Rajan Kumar

Rajan is a web developer with 3 years of experience, specializing in PHP, Laravel, Symfony, ReactJs, NextJs, NodeJs, jQuery, SQL, and Docker. He holds a BCA from Kurukshetra University and has worked on diverse projects in various tech stacks, demonstrating proficiency in both frontend and backend technologies. Rajan is planning to open his own business providing web solutions, website creation, and maintenance services.

For more information, visit Rajan's [GitHub profile](https://github.com/rajansharmax).
