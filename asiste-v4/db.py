# Script para crear la base de datos

import mysql.connector

dataBase = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    passwd = '2002'
)

# Prepare a cursor 
cursorObject = dataBase.cursor()

# Create a data base
cursorObject.execute("CREATE DATABASE asiste_v4")
print("Data base has been created successfully...")
