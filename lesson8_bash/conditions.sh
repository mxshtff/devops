#!/bin/bash

# if [ $# -gt 0 ]
# then
#     if [ $1 == "Hello" ]
#     then
#         echo "Hello!"
#     else
#         echo "Bye!"
#     fi
# else
#     echo 'not parameters'
# fi

[ $# -gt 0 ] && echo "$# parameters" || echo 'not parameters'