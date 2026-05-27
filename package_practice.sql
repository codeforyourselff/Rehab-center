CREATE OR REPLACE PACKAGE EMPLOYEE_MGMT AS
    COMPANY_NAME CONSTANT VARCHAR2(50) := 'HelloCorp';
    PRIVATE_EMPLOYEE_COUNT CONSTANT NUMBER := 0;

    PROCEDURE ADD_EMPLOYEE(
        p_first_name  VARCHAR2,
        p_last_name   VARCHAR2,
        p_hire_date   DATE,
        p_salary      NUMBER
    );
END EMPLOYEE_MGMT;
/

CREATE OR REPLACE PACKAGE BODY EMPLOYEE_MGMT AS
    PROCEDURE ADD_EMPLOYEE(
        p_first_name  VARCHAR2,
        p_last_name   VARCHAR2,
        p_hire_date   DATE,
        p_salary      NUMBER
    ) IS
        v_employee_id NUMBER;
    BEGIN
        DBMS_OUTPUT.put_line('Hello from procedure benchod');
        INSERT INTO employee (first_name, last_name, hire_date, salary)
        VALUES (p_first_name, p_last_name, p_hire_date, p_salary)
        RETURNING emp_id INTO v_employee_id;

        DBMS_OUTPUT.put_line('Inserted employee id: ' || v_employee_id);
    END ADD_EMPLOYEE;
END EMPLOYEE_MGMT;
/