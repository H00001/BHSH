#!/bin/bash
./create.sh
source ./cd-help.sh
show_process 10 "31" 0.1 &
git add . 1>/dev/null 2>&1
show_process 20 "34" 0.2 &
git commit -m "update time:$(date)" 1>/dev/null 2>&1
show_process 40 "35" 0.5 & 
git push 1>/dev/null 2>&1
show_process 100 "36" 0.2
