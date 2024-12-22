#!/usr/bin/env bash
OPERATOR_REGEX='^[+-/*%^]$'
NUMBER_REGEX='^-*[0-9]+(.?[0-9]+)*$'
OUTPUT_FILE="operation_history.txt"

#Script - START

# script operation_history.txt &>/dev/null
touch "$OUTPUT_FILE"  # Clear the file at the start

echo "Welcome to the basic calculator!" | tee -a "$OUTPUT_FILE"
while true; do
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a "$OUTPUT_FILE"
    read -a USER_INPUT
    case "${USER_INPUT[0]}" in
    'quit')
        echo "Goodbye!" | tee -a "$OUTPUT_FILE"
        break
        ;;
    *)
        FIRST_NUMBER=${USER_INPUT[0]}
        OPERATOR=${USER_INPUT[1]}
        SECOND_NUMBER=${USER_INPUT[2]}
        if [ "${#USER_INPUT[@]}" -ne 3 ] || [[ ! "$OPERATOR" =~ $OPERATOR_REGEX ]] || [[ ! "$FIRST_NUMBER" =~ $NUMBER_REGEX ]] || [[ ! "$SECOND_NUMBER" =~ $NUMBER_REGEX ]]; then
            echo "Operation check failed!" | tee -a "$OUTPUT_FILE"
        else
            RESULT=$(echo "scale=2; ${USER_INPUT[@]}" | bc)
            echo "$RESULT" | tee -a "$OUTPUT_FILE"
        fi
        ;;
    esac
done

