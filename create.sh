#!/bin/bash
echo "create at:$(date)" > page.md
cat head.md >> page.md
cat body-0.md >> page.md
cat body-1.md >> page.md
cat body-2.md >> page.md
cat body-3.md >> page.md
cat tail.md >> page.md
./construct_000 page.md page0.md
rm page.md