#!/bin/bash

# $1 - Количество последних дней, за которые необходимо собрать информацию
# $2 - Количество выводимых строк лога

today=$(date "+%Y-%m-%d")
start_date=$(date "+%Y-%m-%d" --date="$1 days ago")


# вывод в терминал

echo "Containers logs from $start_date till $today"
echo -e

for id in $(docker ps -a -q)
  do
    echo $id
    if [[ -n $(docker logs -n $2 --since $start_date $id) ]]
    then
      docker logs -n $2 --since $start_date $id
    else
      echo "empty log"
    fi
    echo -e
  done


# Расскоментируй следующий блок, если необходима запись в файл

# filename="logs_since_$start_date.mt"

# if [[ -f $filename ]]
# then
#   rm $filename
# fi

# echo "Containers logs from $start_date till $today" >> $filename
# echo -e >> $filename

# for id in $(docker ps -a --format "{{.ID}}")
#   do
#     echo $id >> $filename

#     if [[ -n $(docker logs -n $2 --since $start_date $id) ]]
#     then
#       docker logs -n $2 --since $start_date $id >> $filename
#     else
#       echo "empty log" >> $filename
#     fi
#     echo -e >> $filename
#   done
