#!/bin/bash 

args=("$@")       #pinakas me ta arguments

print_user_info()
{
        #pernw thn eggrafh dedomenou enos ID,thn opoia thn apothikeuw proswrina
        grep  ${args[3]} ${args[1]} > tmp.txt
       
	#traps se periptwsh pou ginei kapoio interrupt diagrafontai ta arxeia
        trap "rm $tmp.txt; exit" SIGHUP SIGINT SIGTERM  

        #pernw onoma kai eponumo
        grep -E -o '\|{1}[[:alpha:]]+\|[[:alpha:]]+\|' tmp.txt  | sed 's/|/ /g'>        tmp1.txt
        
        trap "rm $tmp1.txt; exit" SIGHUP SIGINT SIGTERM 

        #pernw hmeromhnia
        grep -E -o '\|[[:digit:]-]+\|' tmp.txt | sed 's@/@-@g'  | sed 's/|//g'>> tmp1.txt

        echo $(cat tmp1.txt)

        rm tmp.txt tmp1.txt
}

print_file()
{
        sed '/#/ d' ${args[1]}
}

print_firstnames()
{    
     #vriskw ta prwta onomata kai ta taksinomw 	
       grep -E -o '\|[[:alpha:]]+\|' ${args[2]} | sed 's/|//g'| sort       
}

print_lastnames()
{
	#vriskw ta epwnuma kai ta taksinomw
        grep -E -o '\|[[:alpha:]]+\|[[:alpha:]]+\|' ${args[2]}  |  grep -E -o '\|[[:alpha:]]+\|$'   | sed 's/|//g'  | sort	
}

print_people_since_until()
{
	awk -F '|' ' $5 > "'${args[1]}'" && $5 < "'${args[3]}'" ' "${args[5]}"
}

print_bornSince()
{
        awk -F'|' ' $5 > "'${args[1]}'" ' "${args[3]}"	
}

print_bornUntil()
{
        awk -F'|' ' $5 < "'${args[1]}'" ' "${args[3]}"
}

print_socialmedia()
{
	   awk -f socialMedia.awk "${args[2]}"
}

column_change()
{
		awk -v id="${args[3]}" -v column="${args[4]}" -v value="${args[5]}" 
			-f changeColumn.awk  "${args[1]}" 
			> tmpfile && mv tmpfile "${args[1]}"
		
}
if [[ $# == 0 ]];then     #h sunthikh elegxei an exw arguments
        echo "1054386-1054361"
	exit 0
fi

if [[ $# == 2 ]];then
        print_file
        exit 0
fi

if [[ $# == 4 ]];then
	if [[ "${args[0]}" == "-f" ]];then
                print_user_info
	        exit 0
	elif [[ "${args[0]}" == "--born-since" ]];then
	        print_bornSince
	        exit 0
	elif [[ "${args[0]}" == "--born-until" ]];then 
	        print_bornUntil
	        exit 0
	else
	        echo "wrong arguments"
	        exit 0  	
	fi	
fi

if [[ $# == 3 ]];then
	if [[ "${args[0]}" == "--firstnames" ]];then
		print_firstnames
		exit 0
	elif [[ "${args[0]}" == "--lastnames" ]];then
		print_lastnames
		exit 0
	else 
	        print_socialmedia
		exit 0
	fi
fi


if [[ $# == 6 ]];then 
	if [[ "$1" == "-f" ]];then
	        column_change
		exit 0
	else
	        print_people_since_until
	        exit 0
	fi
fi 

    

