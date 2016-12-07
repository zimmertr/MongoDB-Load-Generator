#!/bin/bash
count=0
while true;
   do

#Insert write.json into sugarcrm_doc27_table1
mongoimport -u admin -p password --host hostname --db sugarcrm_doc27 --collection sugarcrm_doc27_table1 --file /root/MongoDB/write/write.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Export sugarcrm_doc27_table1 documents to transfer27.json
mongoexport -u admin -p password -h hostname --db sugarcrm_doc27 --collection sugarcrm_doc27_table1 --out /root/MongoDB/write/transfer27.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove contents of sugarcrm_doc27_table1
mongo -u admin -p password hostname/sugarcrm_doc27 --eval 'db.sugarcrm_doc27_table1.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Insert transfer27.json into sugarcrm_doc27_table2
mongoimport -u admin -p password -h hostname --db sugarcrm_doc27 --collection sugarcrm_doc27_table2 --file /root/MongoDB/write/transfer27.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove transfer27.json
rm /root/MongoDB/write/transfer27.json

#Remove contents of sugarcrm_doc27_table2
mongo -u admin -p password hostname/sugarcrm_doc27 --eval 'db.sugarcrm_doc27_table2.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin


    let count=count+1
    echo " " && echo " "
    echo "----------------------------------"
    echo "Script has executed $count time(s)"
    echo "----------------------------------"
    echo " " && echo " "
    if [ -f ./abort ]; then
            echo "Abort file found, exiting..."
                    exit 0
                        fi
done
