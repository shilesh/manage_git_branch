function usage
{
    echo "Usage:"
    echo "./run.sh -n <issue_number> -d <issue_description> -m <update commit message template? (0/1)> -b <base branch for the new branch>"
    exit
}



while [ "$1" != "" ]; do
    case $1 in
        -n | --issue_number )
            echo " issue_number:"$2
            # if [ "$2" == "" ];then
            #     echo ' Issue number is mandatory'
            #     usage
            # fi 
            ISSUE_NO=$2
            ;;
        -d | --issue_description )
            if [ "$1" == "" ];then
                echo ' Issue description is mandatory'
                usage
            fi
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

# Validating mandatory fields

if [ "$ISSUE_DESC" == "" ];then
    echo ' Issue description is mandatory'
    usage
fi 
# if [ "$ISSUE_NO" == "" ];then
#     echo ' Issue number is mandatory'
#     usage
# fi
echo 'Parameters received :' $ISSUE_NO, $ISSUE_DESC, $EDIT_COMMIT_MSG, $ROOT_BRANCH