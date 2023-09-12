import mysql.connector
import os
from datetime import date

use_query = "use turbine_inspection"
myquery1 = "DROP VIEW IF EXISTS majorDamage;" 
myquery2 = "create view majorDamage as \
            select distinct windturbineid, turbinesectiondesc, FlightDate \
            from damageinspection \
            natural join image \
            natural join windturbine \
            natural join turbinesection \
            natural join flight \
            where damageid = 3;" 
myquery3 = "select * from majorDamage;"

try:
    cnx = mysql.connector.connect(user='root', password='password',
    host='127.0.0.1',database='new_university')

    # Prepare a cursor object using cursor() method
    cursor = cnx.cursor ()

    # Execute the SQL query using execute() method.
    cursor.execute (use_query)
    cursor.execute (myquery1)
    cursor.execute (myquery2)
    cursor.execute (myquery3)

    # Fetch all rows
    rows = cursor.fetchall()

    filename = "project2_report.txt"

    if os.path.exists(filename): # Remove file if it already exists
        os.remove(filename)
    with open(filename, 'w') as f:
        f.write(f'Wind Farm Inspection Report - Date: {date.today()}\n')
        for row in rows:
            print(f'Wind turbine ID {row[0]} has major damage on {row[1]} of a blade as of {row[2]}, urgent repairs are required.')
            f.write(f'Wind turbine ID {row[0]} has major damage on {row[1]} of a blade as of {row[2]}, urgent repairs are required.')

except mysql.connector.Error as e:
    print (e)

finally:

    # Close the cursor object
    cursor.close ()

    # Close the connection
    cnx.close ()
