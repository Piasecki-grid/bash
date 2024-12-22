#!/bin/bash

#Global variables - START
DB_CHAR_SIZE=36


#Global variables - END


column_type_menu () {
        echo -e "
        1. varchar
        2. integer
        3. numeric
        "
}


create_new_db () {
        local db="$1"
        sudo -i -u postgres psql -c "CREATE DATABASE "$db";"
        echo "Db created successfully"
}


create_table () {
        local db="$1"
        local table="$2"
        shift 2
        local columns="$@"

        for idx in $(seq 0 "${#columns[@]}"); do
                echo "Choose the type for the specified column: "${columns[idx]}" "
                column_type_menu
                read col_type
                case $col_type in
                        'varchar')

                                ;;
                        'integer')

                                ;;
                        'numeric')

                                ;;
                        *)

                                ;;
                esac
        done

        #sudo -i -u postgres psql -d "$db" -c "CREATE TABLE "$db";"
        echo ""
}


display_data_from_table () {
#
        echo ""
}


insert_data_to_table () {
#
        echo ""
}


#Script - START


#sudo apt update


#sudo apt install postgresql postgresql-contrib -y

#sudo systemctl start postgresql.service

#sudo systemctl enable postgresql.service


read USER_INPUT
OPERATION=$1
DB_NAME=$2

case $OPERATION in
        'create_db')


                if [ "${#DB_NAME}" -gt "$DB_CHAR_SIZE" ]; then
                        echo "Database name is greater than: $DB_CHAR_SIZE" &>2
                        exit 1
                else
                        create_new_db "$DB_NAME"
                        touch "$DB_NAME".txt
                        exit 0
                fi
                ;;
        'create_table')
                shift 2
                TABLE_NAME=$1
                shift
                TABLE_COLUMNS=($@)
                create_table "$DB_NAME" "$TABLE_NAME" "${TABLE_COLUMNS[@]}"

                ;;

        'insert_data')


                ;;
        'delete_data')

                ;;
        *)

                ;;
esac

