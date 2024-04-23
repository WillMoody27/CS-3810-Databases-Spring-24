"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student: William Hellems-Moody
Description: A simple FMS for projects
"""

import os

PRJ_FILE_NAME = "projects.csv"
EMP_FILE_NAME = "employees.csv"

class Entity: 
    """
    models an entity's interface with a key
    """

    def get_key(self) -> any:
        """
        defines a method to return an entity's key (used for search purposes)
        """
        pass

class Employee(Entity): 
    """
    models an employee entity with id, name, and department
    """

    def __init__(self, id, name, department) -> None:
        self.id          = id 
        self.name        = name
        self.department  = department

    def get_key(self): 
        """
        an employee's id is defined as the entity's key
        """
        return self.id

    def __str__(self) -> str:
        """
        returns a string representation of an employee object in csv style
        """
        return str(self.id) + "," + self.name + "," + self.department

class Project(Entity): 
    """
    models a project entity with title, start and end dates, budget, and one or more employees
    """

    def __init__(self, title, start, end, budget, employees) -> None:
        self.title     = title 
        self.start     = start
        self.end       = end
        self.budget    = budget
        self.employees = employees

    def get_key(self): 
        """
        a project's title is defined as the entity's key
        """
        return self.title

    def __str__(self) -> str:
        """
        returns a string representation of a project object in csv style
        """
        return self.title + ',' + self.start + ',' + self.end + ',' + str(self.budget)

class CRUD: 
    """
    models a CRUD (Create, Read, Update, and Delete) interface
    """

    def create(self, entity) -> bool: 
        """
        defines a method to create a new entity
        """
        pass

    def read(self, key) -> any: 
        """
        defines a method to search for an entity by its key
        """
        pass 

    def update(self, entity) -> bool: 
        """
        defines a method to update an entity
        """
        pass

    def delete(self, key) -> bool: 
        """
        defines a method to delete an entity by its key
        """
        pass

class ProjectCRUD(CRUD): 
    """
    models a CRUD for project entities
    """

    def create(self, entity) -> bool:
        """
        a project entity should only be created if it does not exist
        """
        key = entity.get_key()
        result = False
        if not self.read(key): 
            try: 
                prj_file = open(os.path.join('db', PRJ_FILE_NAME), "a")
                prj_file.write(str(entity) + '\n')
                try: 
                    if not os.path.exists(os.path.join("db", key)):
                        # If the key DNE then create the dir of the project
                        os.mkdir(os.path.join("db", key))
                        # Create the employees CSV using the <KEY> db.
                    emp_file = open(os.path.join("db", key, EMP_FILE_NAME), "w")
                    for emp in entity.employees: 
                        emp_file.write(str(emp) + '\n')
                finally: 
                    emp_file.close()
                result = True
            finally: 
                prj_file.close()
        return result

    """
    TODO #1: 
        * open db/projects.csv for reading
        * perform a linear search for the project using the provided key
        * if the project is found, return it
        * else, return None
    """
    def read(self, key) -> Project: 
        try: 
            # Read the correct path of the project.csv file -> db/projects.csv
            projFileContent = open(os.path.join("db", PRJ_FILE_NAME), "r")
            for line in projFileContent.readlines():
                # Parse the data from the current line being read and set the data for the project details.
                line, cols = line.strip(), line.split(",")
                title, start, end, budget = cols[0], cols[1], cols[2], int(cols[3])
                employees = []
                '''
                    NOTE-Completed: Check if the key(title) is equal to the title of the current line, if so then open the employees.csv file for reading.
                    - based on the key provided, open the appropiate employees.csv file for reading, using the key as the path parameter.
                        - sample path for the directory is as follows: db/<key>/employees.csv
                    - iterate through each line in the file and strip the newline char for each line in the employees.csv file and set the data for the employee associated with the key.

                    NOTE-Completed: Iterate through each line and parse the data located within the employees.csv file.
                    - Next set the data for the employee associated with the key provided key from the project.csv file.
                    - Finally, Obtain the id, name, and department of the employee associated with the current project key read by the user. 
                        Append the found employee to the newly created list of employees associated with the current project.
                '''
                if title == key:
                    try: 
                        # One-to-Many
                        emp_file = open(os.path.join("db", key, EMP_FILE_NAME), "r")
                        for line in emp_file.readlines():
                            line, cols = line.strip(), line.split(",")
                            # Init data fields for obj. -> cast the id as and int.
                            id, name, department = int(cols[0]), cols[1], cols[2]
                            # Creates the new employee object.
                            employee = Employee(id, name, department)
                            employees.append(employee) # append the employee objects to the list stored in the temp array.
                    finally: 
                        emp_file.close()
                    return Project(title, start, end, budget, employees) # Return the entire object for the project details.
        except:
            pass
        return None

    def delete(self, key) -> bool: 
        result = False
        if self.read(key): 
            try: 
                file = open(os.path.join("db", PRJ_FILE_NAME), "r")
                lines = file.readlines()
                file.close()
                file = open(os.path.join("db", PRJ_FILE_NAME), "w")
                for line in lines: 
                    line = line.strip()
                    cols = line.split(",")
                    title = cols[0]
                    if title == key:
                        continue
                    file.write(line + "\n")
                result = True
            finally: 
                file.close()
            os.remove(os.path.join("db", key, EMP_FILE_NAME))
            os.rmdir(os.path.join("db", key))
            result = True
        return result
        
class DB:

    """
    TODO #2: 
        * return the employee associated with the (given) id
        * if the employee is not found, return None
    """
    def find_employee(id):
        '''
            NOTE-Completed: Check if the employee based on the id is asscoiated with another project as a single employee can be associated with one project and one only. If the employee is found, return the employee object else continue. 
            - First check if the id entered by the user is associated with any other projects in the database.
            - Next, if the employee is found, return the employee object else continue.
        '''
        try: 
            file = open(os.path.join("db", PRJ_FILE_NAME), "r")
            # Push the id of the new employee to the list of employees associated with the current project.
            for line in file.readlines(): 
                line, cols = line.strip(), line.split(",")
                title = cols[0]
                '''
                    NOTE-Completed: Use the title of the project to open the approate employees.csv.
                    - Next, open the file with the approiate path and read each line in the file for the employee associated with the project.
                    - Set the employee id to the first column in the employees.csv file.
                    - If the id entered by the user is equal to an employee's id, already located in the db then return the employee object.
                '''
                empFile = open(os.path.join("db", title, EMP_FILE_NAME), "r")
                for line in empFile.readlines(): 
                    line, cols = line.strip(), line.split(",")
                    employeeId, name, department = cols[0], cols[1], cols[2]
                    if int(employeeId) == int(id):
                        # Print out the employee details.
                        return Employee(employeeId, name, department)
        except:
            pass
        return None
       
def menu(): 
    print("1. Create")
    print("2. Read")
    print("3. Delete")
    print("4. Quit")
    
if __name__ == "__main__":

    prjCRUD = ProjectCRUD()
    while (True):
        menu()
        option = int(input("? "))
        if option == 1:
            title = input("title? ")
            start = input("start (yyyy-mm-dd)? ")
            end = input("end (yyyy-mm-dd)? ")
            budget = int(input("budget? "))
            employees = []
            print("Now enter employees (first is the manager)!")
            while True:
                line = input("id? ")
                if line == "":
                    break
                id = int(line)
                if DB.find_employee(id): 
                    print('There is already an employee with id ' + str(id) + '!')
                else:
                    name = input("name? ")
                    department = input("department? ")
                    employee = Employee(id, name, department)
                    employees.append(employee)
            project = Project(title, start, end, budget, employees)
            if prjCRUD.create(project): 
                print("New project successfully created!")
            else:
                print("Fail to create a new project!")
        elif option == 2:
            title = input("title? ")
            project = prjCRUD.read(title)
            if project: 
                print(project)
                for emp in project.employees:
                    print('\t' + str(emp))
            else:
                print("Project not found!")
        elif option == 3: 
            title = input("title? ")
            if prjCRUD.delete(title):
                print("Project succcessfully deleted!")
            else:
                print("Fail to delete project!")
        elif option == 4:
            break
        else:
            print("Invalid option!")
    print("Bye!")
