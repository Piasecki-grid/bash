#! /usr/bin/env bash


#functions definition - BEGIN
menu () {
echo "
------------------------------
| Hyper Commander            |
| 0: Exit                    |
| 1: OS info                 |
| 2: User info               |
| 3: File and Dir operations |
| 4: Find Executables        |
------------------------------
"
}



#functions definition - END


#variables - START
CURRENT_USER="${USER}"
FILE_MENU="
---------------------------------------------------
| 0 Main menu | 'up' To parent | 'name' To select |
---------------------------------------------------
"
FILE_OPTION_MENU="
---------------------------------------------------------------------
| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |
---------------------------------------------------------------------
"
#variables - END



#SCRIPT - BEGIN

echo "Hello $CURRENT_USER!"
while true; do

        menu
        read USER_INPUT
        case $USER_INPUT in
                0)
                        echo "Farewell!"
                        break
                ;;

                1)
                        HOSTNAME=$(uname -on)
                        echo -e "\n$HOSTNAME"
                ;;

                2)

                        echo -e "\n$(whoami)"
                ;;

                3)
                        while true; do

                                echo -e "\nThe list of files and directories:"
                                FILE_ARRAY=($(ls))
                                for file in "${FILE_ARRAY[@]}"; do
                                        if [ -f "$file" ]; then
                                        echo "F $file"
                                        elif [ -d "$file" ]; then
                                                echo "D $file"
                                        fi
                                done

                                echo "$FILE_MENU"
                                read USER_CHOICE
                                case $USER_CHOICE in
                                        0)
                                                break
                                                ;;
                                        'up')
                                                cd ..
                                                ;;

                                        *)
                                                FILE_TO_OPERATE_ON="$(ls $USER_CHOICE 2>/dev/null)"
                                                if [ $? -ne 0 ]; then
                                                        echo "Invalid input!"
                                                else
                                                        if [ -d "$USER_CHOICE" ]; then
                                                                cd $USER_CHOICE
                                                        elif [ -f "$USER_CHOICE" ]; then
                                                                while true; do
                                                                        echo "$FILE_OPTION_MENU"
                                                                        read USER_CHOICE
                                                                        case $USER_CHOICE in
                                                                                0)
                                                                                        break
                                                                                        ;;
                                                                                1)
                                                                                        rm -f "$FILE_TO_OPERATE_ON"
                                                                                        echo "$FILE_TO_OPERATE_ON has been deleted."
                                                                                        break
                                                                                        ;;
                                                                                2)
                                                                                        echo "Enter a new file name:"
                                                                                        read NEW_FILE_NAME

                                                                                        mv "$FILE_TO_OPERATE_ON" "$NEW_FILE_NAME"
                                                                                        echo "$FILE_TO_OPERATE_ON has been renamed as $NEW_FILE_NAME"
                                                                                        break
                                                                                        ;;
                                                                                3)
                                                                                        chmod 666 $FILE_TO_OPERATE_ON
                                                                                        echo "Permissions have been updated."
                                                                                        echo "$(ls -al $FILE_TO_OPERATE_ON)"
                                                                                        break
                                                                                        ;;
                                                                                4)
                                                                                        chmod 664 $FILE_TO_OPERATE_ON
                                                                                        echo "Permissions have been updated."
                                                                                        echo "$(ls -al $FILE_TO_OPERATE_ON)"
                                                                                        break
                                                                                        ;;

                                                                        esac
                                                                done

                                                        fi
                                                fi
                                                ;;
                                esac
                        done


                ;;

                4)
                        echo "Enter an executable name:"
                        read USER_CHOICE
                        USER_PATH="$(which $USER_CHOICE)"
                        if [ $? -ne 0 ]; then
                            echo ""
                            echo "The executable with that name does not exist!"
                        else
                            echo "Located in: "$USER_PATH""
                            echo "Enter arguments:"
                            read ARGUMENTS
                            echo "$("$USER_PATH" "$ARGUMENTS" 2>/dev/null)"
                        fi
                ;;

                *)

                        echo -e "\nInvalid option!"
                ;;

        esac
done

