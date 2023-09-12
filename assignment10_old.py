import mysql.connector
import os

add_column_query = "ALTER TABLE enroll ADD COLUMN gradePoints int;\
                    SET SQL_SAFE_UPDATES = 0; \
                    update enroll \
                    set gradePoints = case \
                    when enroll.grade = 'A' then 4 \
                    when enroll.grade = 'B' then 3 \
                    when enroll.grade = 'C' then 2 end;"

myquery = "select enroll.stuid, lastname, firstname, classid, grade, gradepoints \
        from enroll join students on enroll.stuid = students.stuid where enroll.stuid in \
        (select students.stuid from enroll join students on students.stuid = enroll.stuid \
        where majorid = (select majorid from majors where majordesc = 'CSC') \
        group by enroll.stuId having count(*) > 2)"

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
    rows_length = len(rows)
    temp_id = 0 # Used to check if current row is a new student or same as previojs
    point_counter = 0 # Used to add up the grade points for each student
    class_counter = 0 # Will be used to divide the final point_counter to calculate GPA
    stuIds = [] # Record stuIds without duplicates (dupliaces coming from multiple enrolled classes)
    lastNames = [] # Record lastNames without duplicates (dupliaces coming from multiple enrolled classes)
    firstNames = [] # Record firstNames without duplicates (dupliaces coming from multiple enrolled classes)
    GPAs = [] # Record GPA for each stuId
    row_counter = 1 # For determining if we are in the first row or last row

    if os.path.exists("csc_students.txt"): # Remove file if it already exists
        os.remove("csc_students.txt")
    for row in rows:
        print("%d,%s,%s,%d,%s,%d\n" % (row[0], row[1], row[2], row[3], row[4], row[5]))
        if row[0] != temp_id: # If this row is a new student
            temp_id = row[0]
            if row_counter != 1: # All cases except first row
                gpa = point_counter / class_counter # Finalize GPA calculation
                GPAs.append(gpa)
            stuIds.append(row[0])
            lastNames.append(row[1])
            firstNames.append(row[2])
            point_counter = row[5] # Add points for grade
            class_counter = 1 # First class of the student
            row_counter += 1 # Increment for next iteration of for-loop
        else: # Same student as previous row
            point_counter += row[5]
            class_counter += 1 
            if row_counter == rows_length: # Last row, need to calculate GPA since there is no student after
                gpa = point_counter / class_counter # Finalize GPA calculation
                GPAs.append(gpa)
            row_counter += 1 # Increment for next iteration of for-loop

    indices = [] # Find indexes where GPA is not greater than 3.5
    for i in range(0, len(GPAs)):
        if GPAs[i] <= 3.5:
            indices.append(i)

    for i in sorted(indices, reverse=True):
        del stuIds[i]
        del lastNames[i]
        del firstNames[i]
        del GPAs[i]

    with open('csc_students.txt', 'w') as f:
        f.write('stuId,lastName,firstName,GPA\n')
        for i in range(len(GPAs)):
            f.write(f'{stuIds[i]},{lastNames[i]},{firstNames[i]},{GPAs[i]}\n')


except mysql.connector.Error as e:
    print (e)

finally:

    # Close the cursor object
    cursor.close ()

    # Close the connection
    cnx.close ()
