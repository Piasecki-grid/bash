#!/bin/bash


#global variables - START
OPERATION=""
NUMS=()
DEBUG=0
NUM_REG="^[0-9]"
#global variables - END

#function definitions

print_debug () {
        echo "User: $USER"
        echo "Script name: $0"
        echo "Operation: $OPERATION"
        echo "Numbers: "${NUMS[@]}""
}




while getopts ":o:n:d" opt; do
        case "$opt" in
                'o')
                #       echo "$OPTARG"

                #       echo "$OPTIND"
                #       shift $((OPTIND - 1))
                #       echo "$OPTIND"

                        ACCEPTABLE_PARAMS="^(\+|\-|\*|\%)$"
                        if [[ "$OPTARG" =~ $ACCEPTABLE_PARAMS ]]; then
                                OPERATION="$OPTARG"

                        else
                                echo "Operation invalid! "
                                exit 1
                        fi 

                        ;;
                'n')
                        NUMS+=("$OPTARG")
                        ;;
                'd')
                        DEBUG=1
                        #This is for some sort of debug ?
                        ;;
                \?)
                        echo "Invalid option: -$OPTARG" >&2
                        exit 1
                        ;;
        esac
done


shift $((OPTIND - 1))
for i in "$@"; do
        if [[ ! "$i" =~ $NUM_REG ]]; then
                continue
        else
                NUMS+=("$i")
        fi
done

if [ "$DEBUG" -eq 1 ]; then
        print_debug
fi


RESULT=0
for number in "${NUMS[@]}"; do
        RESULT=$(echo "$RESULT $OPERATION $number" | bc)
done

echo "Result: $RESULT"

