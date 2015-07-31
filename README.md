# manage_git_branch
Create and perform basic set up for development_branch based on ticket assigned so that developer can start committing, following a specific format.

Only for Linux flavors with bash script.

only description is mandatory


# Usage

  Place the executable file (bin/run.sh) in ROOT folder of your project.
  
  ```
  ./run.sh -d <issue_description> -n <issue_number> -u <update commit message template? (0/1)> -b <base branch for the new branch>
  ```
  
  ```
  Ex: sh bin/run.sh -d change_email_template -n 0011 -u 1 -b email
  ```
  
  Above command will create a new branch '0011-change_email_template' from 'email' branch after getting the latest from email, Also will be checked out in to  '0011-change_email_template'. 
  Also '~/.gitmessage' file will be edited with ticket details so that developer can simply enter the commit details.
  
# cli
  -d  issue_description <mandatory>
  
  -n  issue_number
  
  -u  update commit message template? (0/1) , defaults to 1.
  
  -b  base branch for the new branch, defaults to master.
  
