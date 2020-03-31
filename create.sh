#!/bin/bash
echo "create at:$(date)" > page.md
cat head.md >> page.md
cat body-0.md >> body.md
cat body-1.md >> body.md
cat body-2.md >> body.md
cat body-3.md >> body.md
./construct_000 body.md body0.md
cat body0.md >> page.md
cat tail.md >> page.md
rm body.md body0.md