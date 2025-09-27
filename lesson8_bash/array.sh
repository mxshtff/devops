#!/bin/bash

export array=(1 2 3 4 5 6)
export array_str=(первый второй третий четвертый)
# echo "Input array:"
# read -a array

echo -e "array\t\t${array[@]}"
echo -e "array_str\t${array_str[@]}"
echo -e "----------\n"

echo -e "array[@]\tAll elements\t\t\t\t${array[@]}"
echo -e "array[*]\tAll elements\t\t\t\t${array[*]}"
echo -e "!array[@]\tAll indices\t\t\t\t${!array[@]}"
echo -e "array:0\t\tElement with index 0\t\t\t${array:0}"
echo -e "array[@]:1\tRange of elements with index 1-end\t${array[@]:1}"
echo -e "array[@]:1:4\tRange of elements with index 1-4\t${array[@]:1:4}"
echo -e "#array[0]\tLength of elements with index 0\t\t${#array[0]}"
echo -e "#array[@]\tLength of array\t\t\t\t${#array[@]}"
echo -e "----------\n"

echo -e "array_str[@]//й/Й\tReplace string\t\t${array_str[@]//й/Й}"
echo -e "----------\n"

echo "Print array elements in loop (@):"
for i in "${array[@]}"; do
    echo "$i"
done
echo -e "----------\n"

echo "Print array elements in loop (*):"
for i in "${array[*]}"; do
    echo "$i"
done

