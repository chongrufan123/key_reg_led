##########################################################################
# File Name: gitttt.sh
# Author: Fan Chongru
# mail: chongrufan123@gmail.com
# Created Time: 2021年03月09日 星期二 13时10分38秒
# notes: 
# permission: 
#########################################################################
#!/bin/Bash
count=1
git push &> /dev/null
while [ $(echo $?) != '0' ]
    do
        count=$((1+$count))
        git push &> /dev/null
    done

echo "本次push尝试了$count次成功" | mail -s "$(basename $(pwd)) push ok" pi 
wall "$(basename $(pwd)) push ok"
