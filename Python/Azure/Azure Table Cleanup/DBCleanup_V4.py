from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity
import pandas as pd
 
#Azure Table Auth Data
cmgname =  ""
tableName = ''
lapscredential =  ""

#instantiation of Table Service
table_service = TableService(account_name= cmgname, sas_token=lapscredential)
tableFilter = "Account eq ''"
listGenerator = table_service.query_entities(table_name=tableName, filter=tableFilter)
outputs = pd.DataFrame(listGenerator) 
temps = pd.DataFrame.to_records(outputs[['SerialNumber','PasswordChanged','Account','PartitionKey','RowKey']])
serialNum = pd.DataFrame(temps)
serialNum = pd.DataFrame.drop_duplicates(serialNum,subset='SerialNumber')
for x in serialNum['SerialNumber']:
    print(x)
    ops = outputs.query('SerialNumber == @x')
    ops = pd.DataFrame.to_records(ops)
    ops = pd.DataFrame(ops).sort_values(by='PasswordChanged',ascending=False).reset_index(drop=True)
    for index, row in ops.iterrows():
        if index > 2:
            print('WARNING: Delete: ',row.PasswordChanged)
            table_service.delete_entity(tableName,row.PartitionKey,row.RowKey,timeout=None)
        else:
            print('VERBOSE: Skip :',row.PasswordChanged)