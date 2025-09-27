#!/bin/bash

# arr=(a b c d e f)
# for i in "${arr[@]}"; do
#     echo "$i"
# done

# arr=(a b c d e f)
# for ((i=0;i<${#arr[@]};i++)); do
#     echo "${arr[$i]}"
# done

# for var in one two three; do
#     # -n print into line
#     echo -n $var' '
# done

# file="/etc/passwd"
# # IFS=$'\n'
# content=$(cat $file)
# for var in $content; do
#     echo $var
# done

# for i in {0..9}; do
#     echo "Check $i"
#     if [ $i -eq 5 ]; then
#         echo $i
#         # go to next iteration
#         continue
#         echo 'Who is next?'
#     elif [ $i -eq 7 ]; then
#         echo $i
#         # end loop
#         break
#     fi
# done

# IFS=$':'
# for dir in $PATH; do
#     echo $dir
#     for exec in $dir/*; do
#         echo -e "\t$exec"
#     done
# done
