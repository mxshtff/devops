#!/bin/bash

show_help() {
  echo "Использование: menu.sh [опции]"
  echo "Опции:"
  echo "  --host              Показать информацию о хосте"
  echo "  --print <аргумент>   Описание опции print, какие аргументы принимает"
  echo "  -h, --help          Показать help"
}
# Объявление длинных ключей
OPTIONS=$(getopt -o "h" -l "help,host,print:" -- "$@")
# echo $OPTIONS
# Вывод help если не передали значения
if [[ $# -eq 0 ]]; then
  show_help
  exit 0
fi
# Парсинг аргументов
eval set -- "$OPTIONS"
# Обработка аргументов
while true; do
  case "$1" in
    -h|--help)
      show_help
      exit 0 ;;
    --host)
      cat /etc/os-release
      shift ;;
    --print)
      echo "$2"
      shift 2 ;;
    --)
      shift
      break ;;
    *)
      echo "Неправильный аргумент"
      exit 1 ;;
  esac
done 