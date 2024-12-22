#!/bin/bash 
#Caesar cipher script

#Global Variables - start
OUTPUT_FILE=""
INPUT_FILE=""
OPERATION=0

shift () {
        cat "$INPUT_FILE" | tr '[A-Za-z]' '[N-ZA-Mn-za-m]' > "$OUTPUT_FILE"
}





#SCRIPT - START

while getopts "si:o:" opt; do
        case $opt in
                s)
                        OPERATION=1
                        ;;
                i)
                        INPUT_FILE="$OPTARG"
                        ;;


                o)
                        OUTPUT_FILE="$OPTARG"
                        ;;

                /?)
                        echo "Invalid version!!!!"
                        exit 1
                        ;;

        esac
done


if [ "$OPERATION" -eq 1 ]; then
        shift
fi

