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

echo '..........  ..........  ..........  ..........'
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

#### Validation for mandatory parameters and usage

function usage
{

    echo "************************* ************************* ************************* ************************* *************************"
    echo "Usage:"
    echo "./run.sh -d <issue_description> -n <issue_number> -u <update commit message template? (0/1)> -b <base branch for the new branch>"
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

# while [ "$1" != "" ]; do
#     case $1 in
#         -n | --issue_number )
#                                 echo " issue_number:"$2
#                                 ISSUE_NO=$2
#                                 ;;
#         -d | --issue_description )
#                                 if [ "$1" == "" ];then
#                                     echo ' Issue description is mandatory'
#                                     usage
#                                 fi
#                                 ISSUE_DESC=$1
#                                 ;;
#         -u | --update_message )
#                                 EDIT_COMMIT_MSG=$1
#                                 ;;
#         -b | --base_branch )
#                                 ROOT_BRANCH=$1
#                                 ;;
#         -h | --help )
#                                 usage
#                                 exit
#                                 ;;
#         * )
#     esac
#     shift
# done

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

echo $msg > .gitmessage
echo '' >> .gitmessage

echo $ISSUE_URL'/'$ISSUE_NO >> .gitmessage
echo '' >> .gitmessage

echo '<Add description here>' >> .gitmessage
echo '' >> .gitmessage
# sed -i -e 's/_/ /g' .gitmessage: Not required

echo "DONE"