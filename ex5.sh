#!/bin/bash

INPUT_FILE=""
OUTPUT_FILE=""
OPERATION=""




lower_with_upper () {
        cat "$INPUT_FILE" | tr 'a-zA-Z' 'A-Za-z' > "$OUTPUT_FILE"
}

replace_char () {
    CHAR1="$1"
    CHAR2="$2"
    sed "s/$CHAR1/$CHAR2/g" "$INPUT_FILE" > "$OUTPUT_FILE"
}

all_to_lower () {
    tr '[:upper:]' '[:lower:]' < "$INPUT_FILE" > "$OUTPUT_FILE"
}


all_to_upper () {
    tr '[:lower:]' '[:upper:]' < "$INPUT_FILE" > "$OUTPUT_FILE"
}


reverse_line () {
        while read line; do
                echo "$line" | rev >> "$OUTPUT_FILE"
        done < "$INPUT_FILE"
        echo ""
}



while getopts "vrlui:o:" opt; do
    case $opt in
        v)
            OPERATION="v"
            ;;
        r)

            OPERATION="r"
            ;;
        l)

            OPERATION="l"
            ;;
        u)

            OPERATION="u"
            ;;
        i)
            INPUT_FILE="$OPTARG"
            cat "$INPUT_FILE"
            ;;
        o)
            OUTPUT_FILE="$OPTARG"
            ;;
        v)
            OPERATION="v"
            ;;
        /?)
                echo " Sth wrong specified"
                exit 1
                ;;
    esac


done
case "$OPERATION" in
        u)
                all_to_upper
                ;;
        v)
                lower_with_upper
                ;;
        r)
                reverse_line
                ;;
        l)
                all_to_lower
                ;;
       





esac


diff "$INPUT_FILE" "$OUTPUT_FILE"
