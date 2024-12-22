

#!/usr/bin/bash
echo -e "Welcome to the Simple converter!\n"
FILENAME="definitions.txt"

menu() {
    echo "Select an option"
    echo "0. Type '0' or 'quit' to end program"
    echo "1. Convert units"
    echo "2. Add a definition"
    echo "3. Delete a definition"
    read -r USER_OPTION
}
while true; do
    menu
    case $USER_OPTION in
        0 | "quit")
            echo "Goodbye!"
            break
            ;;
        1)
            echo "Not implemented!"
            ;;
        2)
            while true; do
                echo "Enter a definition: "
                read -r -a USER_INPUT
                ARR_LENGTH="${#USER_INPUT[@]}"
                DEFINITION="${USER_INPUT[0]}"
                CONSTANT="${USER_INPUT[1]}"
                REGEX_DEFINITION='^[A-Za-z]+_to_[A-Za-z]+$'
                NUMBER_DEFINITION='^-?[0-9]+(\.[0-9]+)?$'
    
                if [ "$ARR_LENGTH" -eq 2 ] && [[ "$DEFINITION" =~ $REGEX_DEFINITION ]] && [[ "$CONSTANT" =~ $NUMBER_DEFINITION ]]; then
                    echo "$DEFINITION $CONSTANT" >> "$FILENAME"
                    break
                else
                    echo "The definition is incorrect!"
                fi
            done
            ;;       
        3)
            if [ -s "$FILENAME" ] && [ ! -e "$FILENAME" ]; then
                echo "Type the line number to delete or '0' to return"

                i=1
                while IFS= read -r LINE; do
                    echo "$i. $LINE"
                    ((i++))
                done < "$FILENAME"

                while true; do
                    read DELETION_LINE
                    LINES_NUMBER=$(cat "$FILENAME" | wc -l)
                    # echo "$LINES_NUMBER"
                    if [[ -z "$DELETION_LINE" ]]; then
                        echo "Enter a valid line number!"
                    elif [ "$DELETION_LINE" -eq 0 ]; then
                        break
                    elif [ "$DELETION_LINE" -lt 1 ] || [ "$DELETION_LINE" -gt $(($LINES_NUMBER + 1)) ]; then
                        echo "Enter a valid line number!"
                    else
                        sed -i "${DELETION_LINE}d" "$FILENAME"
                    fi

                done

            else
                echo "Please add a definition first!"
            fi
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done




