# MongoDB Load Generator


This script is intended to generate load on a MongoDB database for read, write, and deletes. 

When executed, this script will linearlly call several subscripts and append their output to a file. These scripts will import record into a MongoDB instance from the provided JSON file. It will then export each record to a new JSON file, remove the records that were inserted, transfer the exported JSON to a new table, and then remove the contents from that table as well. 

To stop the script simply touch a file named `abort` in the main directory.
