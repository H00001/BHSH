#!/bin/bash
echo "create at:$(date)" > $1/page.md
cat $2/head.md >> $1/page.md
cat $2/body-0.md >> $1/page.md
cat $2/body-1.md >> $1/page.md
cat $2/body-2.md >> $1/page.md
cat $2/body-3.md >> $1/page.md
cat $2/tail.md >> $1/page.md

