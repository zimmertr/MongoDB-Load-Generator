#!/bin/bash
count=0
while true;
   do

#Insert write.json into sugarcrm_doc14_table1
mongoimport -u admin -p password --host hostname --db sugarcrm_doc14 --collection sugarcrm_doc14_table1 --file /root/MongoDB/write/write.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Export sugarcrm_doc14_table1 documents to transfer14.json
mongoexport -u admin -p password -h hostname --db sugarcrm_doc14 --collection sugarcrm_doc14_table1 --out /root/MongoDB/write/transfer14.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove contents of sugarcrm_doc14_table1
mongo -u admin -p password hostname/sugarcrm_doc14 --eval 'db.sugarcrm_doc14_table1.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Insert transfer14.json into sugarcrm_doc14_table2
mongoimport -u admin -p password -h hostname --db sugarcrm_doc14 --collection sugarcrm_doc14_table2 --file /root/MongoDB/write/transfer14.json --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin

#Remove transfer14.json
rm /root/MongoDB/write/transfer14.json

#Remove contents of sugarcrm_doc14_table2
mongo -u admin -p password hostname/sugarcrm_doc14 --eval 'db.sugarcrm_doc14_table2.remove({});' --ssl --sslCAFile /certs/ca.crt --authenticationDatabase admin


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
