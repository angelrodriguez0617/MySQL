-- Add a column to a table
ALTER TABLE history.Students ADD COLUMN lastUpdate date;

-- Modify a column's data type
ALTER TABLE history.Students MODIFY COLUMN lastUpdate timestamp;

-- Rename a column's name
ALTER TABLE history.Students RENAME COLUMN lastUpdate TO myLastUpdate;

-- Drop a column from a table
ALTER TABLE history.Students DROP COLUMN myLastUpdate;

-- View the table
describe history.Students;

-- Rename a table
ALTER TABLE history.Students RENAME history.Students_New;

-- Verify the table was renamed
describe history.Students_New;
