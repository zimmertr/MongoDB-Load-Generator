#!/bin/bash
count=0
while true;
   do

#Insert write.json into sugarcrm_doc24_table1
mongoimport -u admin -p password --host hostname --db sugarcrm_doc24 --collection sugarcrm_doc24_table1 --file /root/MongoDB/write/write.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Export sugarcrm_doc24_table1 documents to transfer24.json
mongoexport -u admin -p password -h hostname --db sugarcrm_doc24 --collection sugarcrm_doc24_table1 --out /root/MongoDB/write/transfer24.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove contents of sugarcrm_doc24_table1
mongo -u admin -p password hostname/sugarcrm_doc24 --eval 'db.sugarcrm_doc24_table1.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Insert transfer24.json into sugarcrm_doc24_table2
mongoimport -u admin -p password -h hostname --db sugarcrm_doc24 --collection sugarcrm_doc24_table2 --file /root/MongoDB/write/transfer24.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove transfer24.json
rm /root/MongoDB/write/transfer24.json

#Remove contents of sugarcrm_doc24_table2
mongo -u admin -p password hostname/sugarcrm_doc24 --eval 'db.sugarcrm_doc24_table2.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin


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
