# Linux only
# dev_branch <branch_name> [options]
# option to include ROOT_BRANCH, default master.

# Ex: sh dev_branch.sh issue_no, issue_desc yes master

# $0 is the name of the command
# $1 first parameter
# $2 second parameter
# $3 third parameter etc. etc
# $# total number of parameters
# $@ all the parameters will be listed

echo " You are here;" 
pwd
echo '..........  ..........  ..........  ..........'

#TODO : Make sure at least one arg present
#TODO : if third is not present default to 'master'
#TODO : $3 Use options, 'yes'
ISSUE_NO=$1
ISSUE_DESC=$2
EDIT_COMMIT_MSG=$3
ROOT_BRANCH=$4

DEV_BRANCH=$ISSUE_NO'_'$ISSUE_DESC

echo $DEV_BRANCH

ISSUE_URL='https://themelt.atlassian.net/browse'

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

msg='Issue #'$ISSUE_NO': '$DESC
echo $msg

echo $msg > .gitmessage 
echo '' >> .gitmessage 

echo $ISSUE_URL'/'$ISSUE_NO >> .gitmessage
echo '' >> .gitmessage 

echo '<Add description here>' >> .gitmessage 
echo '' >> .gitmessage 
# sed -i -e 's/_/ /g' .gitmessage: Not required

echo "DONE"