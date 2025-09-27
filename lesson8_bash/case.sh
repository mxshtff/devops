#!/bin/bash

echo "Input any string and press Enter"
read key

case $key in
    "asd")
        echo "good"
    ;;
    *)
        echo "regexp symbol"
    ;;&
    [0-9])
        echo "regexp digit"
    ;;
esac
