#!/usr/bin/env bash


# #VARIABLES

# CREDENTIALS_URL="http://127.0.0.1:8000/download/file.txt"
# LOGIN_ADDRESS="http://127.0.0.1:8000/login"
# CREDENTIALS_FILE="ID_card.txt"
# COOKIES_FILE="cookies.txt"

# #SCRIPT - START
# sudo apt install jq -y
# echo -e "Welcome to the True or False Game!"
# curl --silent --output "$CREDENTIALS_FILE" "$CREDENTIALS_URL"
# USERNAME=$(cat "$CREDENTIALS_FILE" | jq -r '.username' | tr -d '"')
# PASSWORD=$(cat "$CREDENTIALS_FILE" | jq -r '.password' | tr -d '"')
# echo "Login message: $(curl --silent --cookie-jar "$COOKIES_FILE" --user "$USERNAME:$PASSWORD"  "$LOGIN_ADDRESS")"



menu="
0. Exit
1. Play a game
2. Display scores
3. Reset scores
Enter an option:
"
responses=( "Perfect!" "Awesome!" "You are a genius!" "Wow!" "Wonderful!" )



credentials=ID_card.txt

echo "Welcome to the True or False Game!"
curl --output $credentials --silent http://127.0.0.1:8000/download/file.txt

user=$(grep -o '"username": "[^"]*' $credentials | grep -o '[^"]*$')
pass=$(grep -o '"password": "[^"]*' $credentials | grep -o '[^"]*$')


# echo "Login message: "
curl --silent --cookie-jar cookie.txt -u $user:$pass http://127.0.0.1:8000/login 1>/dev/null



while true; do
    echo "$menu"
    read -r option
    case $option in
        0)
            echo "See you later!"
            break
            ;;
        1)
            RANDOM=4096
            echo "What is your name?"
            read user_name
            CORRECT_ANSWER=0
            while true; do
                RESPONSE="$(curl http://127.0.0.1:8000/game -sb cookie.txt)"
                question=$(echo "$RESPONSE" | sed 's/.*"question": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
                answer=$(echo "$RESPONSE" | sed 's/.*"answer": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
                
                echo "$question"
                echo "True or False?"
                read -r USER_ANSWER

                
                if [ "$USER_ANSWER" == "$answer" ]; then
                    idx=$((RANDOM%5))
                    echo "${responses[idx]}"
                    CORRECT_ANSWER=$((CORRECT_ANSWER + 1))
                else
                    echo "Wrong answer, sorry!"
                    echo "$user_name you have $CORRECT_ANSWER correct answer(s)."
                    SCORE=$(( "$CORRECT_ANSWER" * 10 ))
                    echo "Your score is $SCORE points."
                        
                    echo "User: $user_name, Score: $SCORE, Date: $(date +"%Y"-"%m"-"%d")" >> scores.txt
                    break;
                fi
                
            done
            ;;
        2)
            if [ -f scores.txt  ]; then
                echo "Player scores"
                cat scores.txt
            else
                echo "File not found or no scores in it!"
            fi
            ;;
        3)
            if [ -f scores.txt  ]; then
                rm -f scores.txt
                echo "File deleted successfully!"
            else
                echo "File not found or no scores in it!"
            fi
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done

