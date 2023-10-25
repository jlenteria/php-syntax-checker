#!/bin/bash

echo "Input directory to check PHP files syntax: "

read dirInput

if [ ! -d "$dirInput" ]; then
    echo "Directory not found: $dirInput"
    exit 1
fi

php_files=$(find "$dirInput" -type f | grep ".php" | sort)

for file in $php_files; do
    result=$(php -d error_reporting=32767 -l "$file")
    if [[ "$result" == "No syntax errors detected in $file" ]]; then
        echo "Syntax OK: $file"
    else
        echo "Syntax Error in $file"
        echo "$result"
    fi
done

