#!/bin/bash
set -x

FILE='case.sh'
echo -e "Checks for file\t\t- $FILE"
echo -e "----------\n"

# [ -e FILE ] — файл существует
echo -e "Is file exists (-e):"
if [[ -e $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -d FILE ] — это директория
echo -e "Is file a directory (-d):"
if [[ -d $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -f FILE ] — это обычный файл
echo -e "Is file a regular (-f):"
if [[ -f $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -s FILE ] — размер ненулевой
echo -e "Is file not empty (-s):"
if [[ -s $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -r FILE ] — доступен для чтения
echo -e "is the file readable (-r):"
if [[ -r $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -w FILE ] — доступен для записи
echo -e "is the file writable (-w):"
if [[ -w $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"

# [ -x FILE ] — исполняемый
echo -e "is the file executable (-x):"
if [[ -x $FILE ]]
then echo "Yes" 
else echo "No" 
fi
echo -e "----------\n"
