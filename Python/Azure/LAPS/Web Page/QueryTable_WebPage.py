#Import Libraries
from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity
from flask import Flask, redirect, url_for, render_template, request
from datetime  import datetime
import subprocess
import pandas
import os
import socket
import time

#'Computer\HKEY_LOCAL_MACHINE\SOFTWARE\PPD\IT\DTE' (Move Azure Auth Data to Reg Location)
#Azure Table Auth Data
sasToken = '?sp=raud&st=2021-06-28T11:10:05Z&se=2030-12-31T11:10:00Z&sv=2020-02-10&sig=krU9vOq7okhKd6OHPd%2FLekhoNEJon5T%2FLiBzupsECJU%3D&tn=aadlaps' 
tableName = 'aadlaps'
cmgname =  "ppdsccmcmg"
#Azure Table Auth Data (aadlapslogs)
sasTokenLogs = '?sp=raud&st=2021-06-28T11:24:16Z&se=2030-12-31T11:24:00Z&sv=2020-02-10&sig=r%2FoGGRjCwLxSbViOk5OYCEmgbE1jFwf1dpTSqhJAteQ%3D&tn=aadlapslogs'
logtableName = 'aadlapslogs'
cmgname =  "ppdsccmcmg"

#Decryption Command (PowerShell)
Command = "powershell -executionpolicy bypass -file Rahul\Python\LAPS\WebPage\decrypt.ps1 "

#Azure Table Query
def search_hname(hname):
    table_service = TableService(account_name= cmgname, sas_token=sasToken)
    tableFilter = "(Account eq 'odinsotl' and Hostname eq '"+hname+"')"
    listGenerator = table_service.query_entities(table_name=tableName, filter=tableFilter)
    output = pandas.DataFrame(listGenerator) 
    try:
        output["PasswordChanged"] = pandas.to_datetime(output["PasswordChanged"])
        output = output.sort_values(by='PasswordChanged', ascending=False)
        AzureReturn  = pandas.DataFrame.to_records(output[['Password','PasswordChanged','Account','Hostname']])
    except:
        return 0
    return AzureReturn

def search_snum(snum):
    table_service = TableService(account_name= cmgname, sas_token=sasToken)
    tableFilter = "(Account eq 'odinsotl' and SerialNumber eq '"+snum+"')"
    listGenerator = table_service.query_entities(table_name=tableName, filter=tableFilter)
    output = pandas.DataFrame(listGenerator) 
    try:
        output["PasswordChanged"] = pandas.to_datetime(output["PasswordChanged"])
        output = output.sort_values(by='PasswordChanged', ascending=False)
        AzureReturn  = pandas.DataFrame.to_records(output[['Password','PasswordChanged','Account','Hostname']])
    except:
        return 0
    return AzureReturn

def logging_azure(hname):
    username = os.getlogin()
    TechMachine = socket.gethostname()
    t = time.localtime()
    TimeStamp = time.strftime("%d%m%y%H%M%S", t)
    table_service = TableService(account_name= cmgname, sas_token=sasTokenLogs)
    task = {'PartitionKey': username, 'RowKey': TimeStamp , 'TechMachine': TechMachine, 'HostName': hname}
    table_service.insert_entity(logtableName , task)

#WebPage Creation
app = Flask(__name__)
@app.route("/" , methods=["POST","GET"])
def home():
    if request.method == "POST":
        host = request.form["hostname"]
        serialnum = request.form["serialnum"]
        print(host)
        print(serialnum)
        if host == "":
            if serialnum == "":
                return render_template('hnf.html')
            else:
                results = (search_snum (serialnum.upper()))
        else:        
            results = (search_hname (host.upper()))
        logging_azure(host)
        if results == 0:
            return render_template('hnf.html')
        else:
            for result in results:
                #Password Decryption takes place here. 
                EncryptedPassword = result.Password
                DecryptedPassword = subprocess.run(Command+result.Password, shell=True, capture_output=True)
                result.Password  = DecryptedPassword.stdout.decode()
            return render_template('result.html', results=results)         
    else:
        return render_template('index.html')

if __name__  == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)