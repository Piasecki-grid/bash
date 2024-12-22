

#!/usr/bin/env bash


echo "File Janitor, $(date +%Y)"

# Helper Functions

# Check if the target path exists
check_if_exists() {
    TARGET_PATH=$1
    if [ ! -e "$TARGET_PATH" ]; then
        echo "Error: $TARGET_PATH not found."
        exit 2
    fi
}

# Check if the target path is a directory
check_if_directory() {
    TARGET_PATH=$1
    if [ ! -d "$TARGET_PATH" ]; then
        echo "Error: $TARGET_PATH is not a directory."
        exit 1
    fi
}

# Count files by extension
count_files_by_ext() {
    EXTENSION=$1
    TARGET_PATH=$2
    FILES=$(find "$TARGET_PATH" -name "*.$EXTENSION" -maxdepth 1 | wc -l)
    echo "$FILES"
}

# Count total size of files by extension
count_files_size() {
    EXTENSION=$1
    TARGET_PATH=$2
    SIZE=$(find "$TARGET_PATH" -name "*.$EXTENSION" -maxdepth 1 -exec cat {} + | wc -c)
    echo "$SIZE"
}

# Delete files by extension
delete_files_by_ext() {
    EXTENSION=$1
    TARGET_PATH=$2
    COUNT=$(find "$TARGET_PATH" -name "*.$EXTENSION" -maxdepth 1 -exec rm -f {} + | wc -l)
    echo "$COUNT"
}

# Move files by extension
mv_files_by_ext() {
    EXTENSION=$1
    TARGET_PATH=$2
    DEST_DIR="${TARGET_PATH}/python_scripts"
    mkdir -p "$DEST_DIR"
    COUNT=$(find "$TARGET_PATH" -name "*.$EXTENSION" -maxdepth 1 -exec mv {} "$DEST_DIR/" \; | wc -l)
    echo "$COUNT"
}

# Main Script Logic

OPTION=$1
HELP_FILE="file-janitor-help.txt"

if [ "$#" -eq 0 ]; then
    echo "Usage: file-janitor.sh <command>"
    echo "Type 'file-janitor.sh help' to see available options."
    exit 1
fi

case "$OPTION" in
    list)
        shift
        if [ "$#" -eq 0 ]; then
            echo "Listing files in the current directory:"
            ls -A1
        else
            TARGET_PATH=$1
            check_if_exists "$TARGET_PATH"
            check_if_directory "$TARGET_PATH"
            echo "Listing files in $TARGET_PATH:"
            ls -A1 "$TARGET_PATH"
        fi
        ;;

    help)
        cat "$HELP_FILE"
        ;;

    report)
        shift
        TARGET_PATH=${1:-$(pwd)}
        check_if_exists "$TARGET_PATH"
        check_if_directory "$TARGET_PATH"

        echo "Report for $TARGET_PATH:"
        TMP_FILES=$(count_files_by_ext "tmp" "$TARGET_PATH")
        LOG_FILES=$(count_files_by_ext "log" "$TARGET_PATH")
        PY_FILES=$(count_files_by_ext "py" "$TARGET_PATH")

        TMP_SIZE=$(count_files_size "tmp" "$TARGET_PATH")
        LOG_SIZE=$(count_files_size "log" "$TARGET_PATH")
        PY_SIZE=$(count_files_size "py" "$TARGET_PATH")

        echo "$TMP_FILES tmp file(s), total size: $TMP_SIZE bytes"
        echo "$LOG_FILES log file(s), total size: $LOG_SIZE bytes"
        echo "$PY_FILES py file(s), total size: $PY_SIZE bytes"
        ;;

    clean)
        shift
        TARGET_PATH=${1:-$(pwd)}
        check_if_exists "$TARGET_PATH"
        check_if_directory "$TARGET_PATH"

        echo "Cleaning $TARGET_PATH..."
        TMP_FILES=$(delete_files_by_ext "tmp" "$TARGET_PATH")
        LOG_FILES=$(delete_files_by_ext "log" "$TARGET_PATH")
        PY_FILES=$(mv_files_by_ext "py" "$TARGET_PATH")

        echo "Deleted $LOG_FILES log file(s)."
        echo "Deleted $TMP_FILES tmp file(s)."
        echo "Moved $PY_FILES Python file(s) to 'python_scripts/'."
        echo "Clean-up of $TARGET_PATH is complete."
        ;;

    *)
        echo "Unknown command: $OPTION"
        echo "Type 'file-janitor.sh help' to see available options."
        ;;
esac




