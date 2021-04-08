#!/bin/bash
#
# bitninjacmd - Use script for add IPs rules in mass by the server in system bitninja
#                  
#
# Author  : Icaro Henrique de Oliveira Werly
# e-mail : icaro@sierti.com
#
# Date      : 28/07/2020
# Version    : 1.00
# 
# File organization
# bitninjacmd.allow -> IPs for whitelist
# bitninjacmd.denny -> IPs for blacklist
# bitninjacmd.neutral -> IPs for neutrallist

#var_globals-----------------------------------------------------------------------------

whitelist_file="/scripts/bitninjacmd/bitninjacmd.allow"
blacklist_file="/scripts/bitninjacmd/bitninjacmd.deny"
neutrallist_file="/scripts/bitninjacmd/bitninjacmd.neutral" #Use to remove IPs from the blacklist and whitelist
regex_ip='^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]){1}(\/([0-9]|[1-2][0-9]|3[0-2]))?$' #Check if IP valid number
#-----------------------------------------------------------------------------------------



execute_bitninja()
{
    OPTION=$1
    
    if [ "$OPTION" = "1" ]
    then
        file=$blacklist_file
        function="blacklist"

    elif [ "$OPTION" = "2" ]
    then
        file=$whitelist_file
        function="whitelist"

    elif [ "$OPTION" = "3" ]
    then
        file=$neutrallist_file

    else
        echo "Option incorret! Please, try again."
        exit
    fi

    numbers_ip_list=$(wc -l $file | cut -d " " -f1)
    for i in $(seq 1 "$numbers_ip_list")
    do
        line=$(cat $file | tail -n "$i" | head -n 1 )
        ip=$(echo "$line" | cut -d "#" -f1 | sed -e 's/ //g')
        comment=$(echo "$line" | cut -d "#" -f2)
        if ! [[ $ip =~ $regex_ip ]]; then continue; fi 
        
        #only neutral list (provisore solution)
        if [ "$OPTION" = "3" ]
        then
            bitninjacli --blacklist --del="$ip" 
            bitninjacli --whitelist --del="$ip" 
            continue
        fi

        bitninjacli --$function --add="$ip" --comment="$comment"
    done
}

echo "Integrated Bitninja system"
echo "Select an option"
echo ""
echo "1 - Blacklist"
echo "2 - Whitelist"
echo "3 - Neutrallist"
echo "4 - Exit"
echo ""
read -p "Option: " option

execute_bitninja "$option"
