import mysql.connector

myquery = "select stuID,lastName,firstName,major,credits from Students"

try:
    cnx = mysql.connector.connect(user='<user>', password='<password>',
    host='127.0.0.1',database='new_university')

    # Prepare a cursor object using cursor() method
    cursor = cnx.cursor ()

    # Execute the SQL query using execute() method.
    cursor.execute (myquery)

    # Fetch all rows
    rows = cursor.fetchall()
    for row in rows:
        print("%s,%s,%s,%s,%d\n" % (row[0] , row[1], row[2], row[3], row[4] ))

except mysql.connector.Error as e:
    print (e)

finally:

    # Close the cursor object
    cursor.close ()

    # Close the connection
    cnx.close ()
