#!/bin/bash

NUM_REG="^[0-9]+"
USER_INPUT=$1
RESULT=( 0 1 )
if [[ ! "$USER_INPUT" =~ $NUM_REG ]] || [ "$#" -eq 0 ]; then
        echo "Enter a number in range 0..n"
fi

case $USER_INPUT in
        0)
                echo "0"
                ;;
        1)
                echo "1"
                ;;

        *)
                NUM1=0
                NUM2=1

                for i in $(seq 1 $((USER_INPUT - 2))); do
                        NEXT=$((NUM1+NUM2))
                        NUM1="$NUM2"
                        NUM2="$NEXT"
                        RESULT+=("$NUM2")
                done

                ;;

esac


echo "${RESULT[@]}"

