#!/bin/bash

start () {
    echo "start"
}

restart () {
    echo "restart"
}

stop () {
    echo "stop"
}

start
echo $?
restart
echo $?
stop
echo $?