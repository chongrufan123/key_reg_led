##########################################################################
# File Name: gitttt.sh
# Author: Fan Chongru
# mail: chongrufan123@gmail.com
# Created Time: 2021年03月09日 星期二 13时10分38秒
# notes: 
# permission: 
#########################################################################
#!/bin/Bash

git push &> /dev/null
while [ $(echo $?) != '0' ]
    do
        git push &> /dev/null
    done

mail -s "$(basename $(pwd)) push ok" pi <<< ""

