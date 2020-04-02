#!/bin/bash
tmp_file="$RANDOM"
paper_file="paper.md"
echo "> create at:$(date)" > ${paper_file}
cat body-0.md >> ${tmp_file}
cat body-1.md >> ${tmp_file}
cat body-2.md >> ${tmp_file}
cat body-3.md >> ${tmp_file}
cat body-4.md >> ${tmp_file}
if [[ "$1" == "-flag" ]]; then
    ./construct_000 ${tmp_file} ${tmp_file}
fi
cat head.md >> ${paper_file}
cat ${tmp_file} >> ${paper_file}
cat tail.md >> ${paper_file}
cat follow.md >> ${paper_file}
rm ${tmp_file}
echo -e "create [SUCCEED]"