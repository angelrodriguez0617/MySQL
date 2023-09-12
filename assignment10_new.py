import mysql.connector
import os

add_column_query = "ALTER TABLE enroll ADD COLUMN gradePoints int;\
                    SET SQL_SAFE_UPDATES = 0; \
                    update enroll \
                    set gradePoints = case \
                    when enroll.grade = 'A' then 4 \
                    when enroll.grade = 'B' then 3 \
                    when enroll.grade = 'C' then 2 end;"

myquery = "SELECT enroll.stuid, lastName, firstname, SUM(enroll.gradePoints)/count(enroll.classid) as GPA \
        FROM enroll join students on students.stuid = enroll.stuid \
        where majorid = (select majorid from majors where majordesc = 'CSC') \
        GROUP BY enroll.stuId having count(*) > 2 and GPA > 3.5;" 


try:
    cnx = mysql.connector.connect(user='root', password='password',
    host='127.0.0.1',database='new_university')

    # Prepare a cursor object using cursor() method
    cursor = cnx.cursor ()

    # Execute the SQL query using execute() method.
    # cursor.execute (add_column_query) # Add gradePoints column if not already added
    cursor.execute (myquery)

    # Fetch all rows
    rows = cursor.fetchall()

    if os.path.exists("csc_students.txt"): # Remove file if it already exists
        os.remove("csc_students.txt")
    with open('csc_students.txt', 'w') as f:
        f.write('stuId,lastName,firstName,GPA\n')
        for row in rows:
            print("%d,%s,%s,%.4f\n" % (row[0], row[1], row[2], row[3]))
            f.write("%d,%s,%s,%.4f\n" % (row[0], row[1], row[2], row[3]))

except mysql.connector.Error as e:
    print (e)

finally:

    # Close the cursor object
    cursor.close ()

    # Close the connection
    cnx.close ()
