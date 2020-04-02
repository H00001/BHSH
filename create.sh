#!/bin/bash
tmp_file="$RANDOM"
paper_file="paper.md"
cat body-0.md >> ${tmp_file}
cat body-1.md >> ${tmp_file}
cat body-2.md >> ${tmp_file}
cat body-3.md >> ${tmp_file}
cat body-4.md >> ${tmp_file}
if [[ "$1" == "-flag" ]]; then
    ./construct_000 ${tmp_file} ${tmp_file}
fi

if [[ "$(uname)" == "Darwin" ]]; then
    sha="shasum -a 256 "
elif [[ "$(expr substr $(uname -s) 1 5)"=="Linux" ]];then
    sha="sha256sum "
fi
echo "> create at:$(date) sha256:$(${sha} ${tmp_file})" > ${paper_file}
cat head.md >> ${paper_file}
cat ${tmp_file} >> ${paper_file}
cat tail.md >> ${paper_file}
cat follow.md >> ${paper_file}
rm ${tmp_file}
echo -e "create [SUCCEED]"