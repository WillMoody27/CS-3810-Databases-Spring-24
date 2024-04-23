import csv

"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Description: A simple FMS for employees
"""

# NOTE - This is a abstract class
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

'''
Defines the basic CRUD operations for an employee entity
 - NOTE -> Create will create an employee object
 - NOTE -> Read will return an employee object
 - NOTE -> Update will delete the employee object and re-create it and change some aspect.
 - NOTE -> Delete will delete the employee object

'''
class EmployeeCRUD(CRUD): 
    """
    models a CRUD for employee entities
    """

    def __init__(self, file_name): 
        """
        an employee CRUD is defined by its file name (used for storage)
        """
        self.file_name = file_name

    def create(self, entity) -> bool:
        """
        an employee entity should only be created if it does not exist
        """
        key = entity.get_key()
        result = False
        '''
         - If there note employee with the key, then create the employee
        '''
        if not self.read(key): 
            try: 
                # This will open the file and append the employee to the file
                file = open(self.file_name, "a")
                # This will write the employee to the file
                file.write(str(entity) + "\n")
                result = True
            finally: 
                file.close()
        return result

    def read(self, key) -> Employee: 
        """
        TODO #1: 
            * open the (storage) file for reading
            * perform a linear search for the entity using the provided key
            * if the entity is found, return it
            * else, return None
        """
        employee = None
        try: 
            # Read the line from the file and remove the dimiliter
            with open(self.file_name, "r") as file:
                for line in file: 
                    id, name, department = line.split(",")
                    id = int(id)
                    if id == key:
                        employee = Employee(id, name, department)
                        break
        except: 
            pass
        return employee

    # def update(self, entity) -> bool: 
    #     """
    #     TODO #2: delete the entity (using the key) then re-create it
    #     """
    #     # Option 1: Create a new and copy all the employees except the one that should be deleted
    #     result = False
    #     try: 
    #         # Using with open to open the file and read the lines - this will automatically close the file when done.
    #         with open(self.file_name, "r") as file:
    #             lines = file.readlines()
    #             file.close()
    #             file = open(self.file_name, "w")
    #             for line in lines: 
    #                 line = line.strip()
    #                 cols = line.split(",")
    #                 id = int(cols[0])
    #                 # If the current line that we are deleting is the key, then skip it.
    #                 if id == entity.get_key(): 
    #                     continue
    #                 file.write(line + "\n")
    #             file.write(str(entity) + "\n")
    #             result = True
    #     except:
    #         pass
    #     return result

    def update(self, entity) -> bool: 
        self.delete(self, entity.get_key)
        self.create(self, entity)



        

    def delete(self, key) -> bool: 
        """
        TODO #3: 
            * open the (storage) file for reading
            * read all of the lines in memory
            * re-open the (storage) file for writing
            * copy all of the entities, except the one that should be deleted

            - If MEM is an issue then we can use the following: 
                * create a new file
                * copy all of the entities, except the one that should be deleted
                * delete the old file
                * rename the new file to the old file's name

        """
        # Option 1: Create a new and copy all the employees except the one that should be deleted

        # Option 1
        result = False
        try: 
            # Using with open to open the file and read the lines - this will automatically close the file when done.
            with open(self.file_name, "r") as file:
                lines = file.readlines()
                file.close()
                file = open(self.file_name, "w")
                for line in lines: 
                    line = line.strip()
                    cols = line.split(",")
                    id = int(cols[0])
                    # If the current line that we are deleting is the key, then skip it.
                    if id == key: 
                        continue
                    file.write(line + "\n")
                result = True
        except:
            pass
        return result

                
def menu(): 
    print("1. Create")
    print("2. Read")
    print("3. Update")
    print("4. Delete")
    print("5. Quit")

FILE_NAME = "employees.csv" 
    
if __name__ == "__main__":

    # Print the 

    empCRUD = EmployeeCRUD(FILE_NAME)
    while (True):
        menu()
        option = int(input("? "))
        if option == 1:
            id = int(input("id? "))
            name = input("name? ")
            department = input("department? ")
            employee = Employee(id, name, department)
            if empCRUD.create(employee): 
                print("New employee successfully created!")
            else:
                print("Fail to create a new employee!")
        elif option == 2:
            id = int(input("id? "))
            employee = empCRUD.read(id)
            if employee: 
                print(employee)
            else:
                print("Employee not found!")
        elif option == 3: 
            id = int(input("id? "))
            name = input("name? ")
            department = input("department? ")
            employee = Employee(id, name, department)
            if empCRUD.update(employee):
                print("Employee successfully updated!")
            else:
                print("Fail to update employee!")
        elif option == 4: 
            id = int(input("id? "))
            if empCRUD.delete(id):
                print("Employee successfully deleted!")
            else:
                print("Fail to delete employee!")
        elif option == 5:
            break
        else:
            print("Invalid option!")
    print("Bye!")
