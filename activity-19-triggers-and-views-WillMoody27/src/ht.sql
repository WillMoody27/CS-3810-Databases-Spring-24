CREATE PROCEDURE give_employees_raise(perc FLOAT)
    LANGUAGE sql
        AS $$
        UPDATE Employees SET sal = sal * (1 + perc)
        $$;
CALL give_employees_raise(.5);


CREATE FUNCTION sal_from_id(id INT) RETURNS FLOAT
LANGUAGE sql
    AS $$
        SELECT sal FROM Employees WHERE "id" = id
    $$;
SELECT * FROM sal_from_id(101);


DROP FUNCTION IF EXISTS validate_sal(sal FLOAT);

CREATE FUNCTION validate_sal(sal FLOAT) RETURNS FLOAT
    LANGUAGE plpgsql
        AS $$
            BEGIN
                IF sal < 50000 THEN
                    RETURN 30000;
                ELSE
                    RETURN sal;
                END IF;
            END;
        $$;

INSERT INTO Employees VALUES (303, 'Mary', validate_sal(30000));

DELETE FROM Employees WHERE id = 303;

-- TRIGGERS
CREATE FUNCTION check_sal_before_insert() RETURNS TRIGGER
    LANGUAGE plpgsql
        AS $$
            BEGIN
                IF NEW.sal < 50000 THEN
                    NEW.sal = 50000;
                END IF;
                    RETURN NEW;
                END;
        $$;

    
CREATE TRIGGER employees_sal_at_least_50K
    BEFORE INSERT ON Employees
        FOR EACH ROW
            EXECUTE PROCEDURE check_sal_before_insert();

INSERT INTO Employees VALUES 
(54, 'Jane', 32000),
(51, 'Jake', 37000),
(52, 'John', 39000);

INSERT INTO Employees VALUES 
(56, 'John', 60000);

DELETE FROM Employees WHERE id = 50;