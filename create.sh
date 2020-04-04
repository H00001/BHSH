#!/bin/bash
source cd-help.sh
tmp_file="$RANDOM"
paper_file="paper.md"


function error_clean() {
    rm ${tmp_file}
    rm ${paper_file}
    exit $1
}

show_process 10 "32" 0.01 "create temp" 0
cat body-0.md >> ${tmp_file}
cat body-1.md >> ${tmp_file}
cat body-2.md >> ${tmp_file}
cat body-3.md >> ${tmp_file}
cat body-4.md >> ${tmp_file}
show_process 30 "32" 0.01 "mapping file" 10

if [[ "$(uname)" == "Darwin" ]]; then
    sha="shasum -a 256 "
    flag="./flag-mac"
elif [[ "$(expr substr $(uname -s) 1 5)"=="Linux" ]];then
    sha="sha256sum "
    flag="./flag-gnu"
fi
if [[ "$1" == "-flag" ]]; then
    $(${flag} ${tmp_file} ${tmp_file})
    if [[ $? -ne 0 ]]; then
        echo -e "error"
        error_clean $?
    fi
fi

show_process 60 "32" 0.01 "reduce file" 30
echo "> create at:$(date) sha256:$(${sha} ${tmp_file})" > ${paper_file}

show_process 90 "32" 0.02 "check file sha1" 60
cat head.md >> ${paper_file}
echo -e "\n# 目 录\n[TOC]\n" >> ${paper_file}
cat ${tmp_file} >> ${paper_file}
cat tail.md >> ${paper_file}
cat follow.md >> ${paper_file}
rm ${tmp_file}

show_process 100 "32" 0.01 "complete !!!" 90

echo -e "create file [SUCCEED]"
echo -e "字节:\t"$(wc -c ${paper_file})
echo -e "字数:\t"$(wc -m ${paper_file})
echo -e "行数:\t"$(wc -l ${paper_file})
echo -e "质量:\t优秀"
