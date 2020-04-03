#!/bin/bash
source ./cd-help.sh
show_process 10 0.1
git add .
show_process 20 0.2
git commit -m "update time:$(date)"
show_process 40 0.3
git push
show_process 100 0.2
