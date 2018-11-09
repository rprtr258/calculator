#!/bin/bash

echo "Welcome to SAFEST STORAGE EVER!!!!!"
echo "put/get ?"
read cmd

echo "Token ?"
read filename

if [[ $cmd == "put" ]]; then
    echo "Secret?"
    read flag
    bash -c "echo $flag > storage/$filename"
    echo "OK!"
elif [[ $cmd == "get" ]]; then
    echo "Your secret:"
    bash -c "cat storage/$filename"
else
    echo "Bad command"
    exit 1
fi
