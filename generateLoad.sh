#!/bin/bash
rm -f ./abort
for((i=1;i<31;i++));
do
   nohup bash ./write/writedelete${i}.sh >/dev/null 2>&1 &
done
