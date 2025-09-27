#!/bin/bash

str1='first'
str2='second'
echo -e "First string\t- '$str1'"
echo -e "Second string\t- '$str2'"
echo -e "----------\n"

# -z # строка пуста
echo -e "Is the string 'str1' empty (-z):"
if [ -z $str1 ]
then echo "String is empty" 
else echo "String is not empty" 
fi
echo -e "----------\n"

# -n # строка не пуста
echo -e "Is the string 'str2' not empty (-n):"
if [ -n $str2 ]
then echo "String is not empty" 
else echo "String is empty" 
fi
echo -e "----------\n"

# =, (==) # строки равны
echo -e "Are the strings 'str1', 'str2' equal (==):"
if [ $str1 == $str2 ]
then echo "Strings are equal" 
else echo "Strings are not equal" 
fi
echo -e "----------\n"

# != # строки неравны
echo -e "Are the strings 'str1', 'str2' not equal (!=):"
if [ $str1 != $str2 ]
then echo "Strings are not equal" 
else echo "Strings are equal" 
fi
echo -e "----------\n"

echo -e "'str1' is greater than 'str2' (>):"
if [[ $str1 > $str2 ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

echo -e "'str1' is less than 'str2' (<):"
if [[ $str1 < $str2 ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"
