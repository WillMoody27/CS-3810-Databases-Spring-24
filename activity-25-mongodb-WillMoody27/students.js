// open fresh database name students
use students

// create a new collection also name students
db.createCollection("students")

// insert some documents into students
db.students.insert({"id": 1, "name": "John"})
db.students.insert({"id": 2, "name": "Anna", "courses": ["CS120", "CS265"]})
db.students.insert({"name": "Jane", "year": 2022, "major": "Chemistry"})

// list all of the documents in students
print("list all of the documents in students:")
db.students.find()

/**
 * The find method is used to query the database. The first argument is the query,
 * which is a document that specifies the criteria for selecting documents. The
 * second argument is the projection, which is a document that specifies which fields to include in the result.
 * 
 * **/

// a simple select
print("a simple select:")
db.students.find({"year": 2022})

// a simple projection
print("a simple projection:")
db.students.find({}, {"name": 1})

// a selection and projection
print("a selection and projection:")
db.students.find({"year": 2022}, {"name": 1}) // Selection and projection

// DELETE all documents in students
db.students.remove({})


/*
USEFUL COMMANDS:

-- Clear the screen
cls

-- Show databases
show dbs

-- Show collections
show collections

-- Drop a database
db.dropDatabase()

-- Drop a collection
db.students.drop()

-- List all of the documents in students
db.students.find()

-- A simple select
db.students.find({"year": 2022})

-- A simple projection
db.students.find({}, {"name": 1})
*/