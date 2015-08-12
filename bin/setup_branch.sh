#!/usr/bin

# Linux only
# Ex: ./setup_branch.sh -h

echo '..........  ..........  ..........  ..........'
echo " You are here;"
pwd
echo '..........  ..........  ..........  ..........'


ISSUE_URL='https://themelt.atlassian.net/browse'

#### Validation for mandatory parameters and usage

function usage
{

    echo "************************* ************************* ************************* ************************* *************************"
    echo "Usage:"
    echo "./setup_branch.sh -d <issue_description> -n <issue_number> -u <update commit message template? (0/1)> -b <base branch for the new branch>"
    echo "************************* ************************* ************************* ************************* *************************"
    exit
}

while getopts ":n:d:u:b:h:" opt; do
  case $opt in
    n) ISSUE_NO="$OPTARG"
    ;;
    d) ISSUE_DESC="$OPTARG"
    ;;
    u) EDIT_COMMIT_MSG="$OPTARG"
    ;;
    b) ROOT_BRANCH="$OPTARG"
    ;;
    h) usage
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

DEV_BRANCH=$ISSUE_NO'_'$ISSUE_DESC

echo $ISSUE_NO
echo $ISSUE_DESC
echo 'New branch will be -> '$DEV_BRANCH

# Validating mandatory fields

if [ "$ISSUE_DESC" == "" ];then
    echo ' Issue description is mandatory'
    usage
fi

##### git process starts

echo 'Parameters received :' $ISSUE_NO, $ISSUE_DESC, $EDIT_COMMIT_MSG, $ROOT_BRANCH
echo 'Moving to Root Branch :' $ROOT_BRANCH
git checkout $ROOT_BRANCH

echo 'Clean Branch ' $ROOT_BRANCH
git reset --hard HEAD

echo 'Latest from ' $ROOT_BRANCH
git pull origin $ROOT_BRANCH

echo 'Creating new Branch and move in':$DEV_BRANCH
git branch $DEV_BRANCH
git checkout $DEV_BRANCH

echo 'Verify if everything is correct'
git branch

#TODO: # Check if you have permission from user, options['-e']
echo 'Updating commit message'
# Replacing _ with <space>
echo $ISSUE_DESC

DESC=${ISSUE_DESC//_/ }
echo $DESC

# Issue number is not mandatory
# if [ "$ISSUE_NO" == "" ];then
#   ISSUE_NO=''
# fi

msg='Issue #'$ISSUE_NO': '$DESC
echo $msg

echo $msg > ~/.gitmessage.txt
echo '' >> ~/.gitmessage.txt

echo $ISSUE_URL'/'$ISSUE_NO >> ~/.gitmessage.txt
echo '' >> ~/.gitmessage.txt

echo '<Add description here>' >> ~/.gitmessage.txt
echo '' >> ~/.gitmessage.txt

# sed -i -e 's/_/ /g' .gitmessage: Not required

echo "DONE"
