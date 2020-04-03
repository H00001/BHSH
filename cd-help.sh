
#!/bin/bash
i=0
str=">"

arr=("|" "/" "-" "\\")
function show_process() {
    while [[ ${i} -le $1 ]]
    do
    let index=i%4
    printf "\e[0;$2;1m[%-100s][%d%%]%c\e[0m %s\r" "$str" "$i" "${arr[${index}]}" "$4"
    sleep $3
    let i++
    str='='${str}
    done
    if [[ $1 -eq 100 ]]; then
        printf "\e[0m\n"
    fi
}
