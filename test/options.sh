function usage
{
    echo "Usage:"
    echo "./run.sh -n <issue number> -d <issue description> -m <update commit message template? (0/1)> -b <base branch for the new branch>"
    exit
}

while [ "$1" != "" ]; do
    case $1 in
        -n | --issue_number )
            echo " issue_number:"$2
                                ISSUE_NO=$2
                                ;;
        -d | --issue_description )
                                ISSUE_DESC=$1
                                ;;
        -u | --update_message )
                                EDIT_COMMIT_MSG=$1
                                ;;
        -b | --base_branch ) 
                                ROOT_BRANCH=$1
                                ;;
        -h | --help ) 
                                usage
                                exit
                                ;;
        * )                     
                                # exit 1
    esac
    shift
done

echo 'Parameters received :' $ISSUE_NO, $ISSUE_DESC, $EDIT_COMMIT_MSG, $ROOT_BRANCH