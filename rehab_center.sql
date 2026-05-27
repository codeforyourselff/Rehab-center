Select to_char(sysdate,'DD MM YYYY Day Month Year HH:MI:SS Am') AS REHAB_CENTER_EXECUTION from dual;

--connect to rehab_center user
connect rehab_center/123;

SPOOL rehab_center_menu.txt;

SET SERVEROUTPUT ON;

BEGIN
      DBMS_OUTPUT.put_line('------------------------------Main Menu------------------------------');
      DBMS_OUTPUT.put_line('1 Check patient status and register');
      DBMS_OUTPUT.put_line('2 Appointments for patient');
      DBMS_OUTPUT.put_line('3 Appointments only patient can book');
      DBMS_OUTPUT.put_line('4 List of doctors');
      DBMS_OUTPUT.put_line('5 Fetch doctor by id');
      DBMS_OUTPUT.put_line('5 Exit');
      DBMS_OUTPUT.put_line('------------------------------END OF MENU----------------------------');
END;
/

ACCEPT user_input PROMPT 'Please enter your choice from the above menu: ';
DEFINE user_input = &user_input;

BEGIN
  DBMS_OUTPUT.put_line('----------------------------------------------------------------------');
END;
/

ACCEPT user_input_patient_id PROMPT 'Please enter patient_id: ';
DEFINE user_input_patient_id = &user_input_patient_id;

BEGIN
  DBMS_OUTPUT.put_line('----------------------------------------------------------------------');
END;
/

ACCEPT user_input_doctor_id PROMPT 'Please enter doctor_id: ';
DEFINE user_input_doctor_id = &user_input_doctor_id;


declare
    user_input NUMBER := &user_input;
    user_input_patient_id NUMBER := &user_input_patient_id;
    user_input_doctor_id NUMBER := &user_input_doctor_id;
BEGIN
    CASE 
        WHEN user_input = 1 THEN
          declare
              patient_cursor SYS_REFCURSOR;
              patient_info Physio_patients%ROWTYPE;
              patient_id rehab_center.Physio_patients.patient_id%TYPE;
          BEGIN
            DBMS_OUTPUT.put_line('Lets check the current status of patients which you entered.');
            DBMS_OUTPUT.put_line('------------------------------------------------------------');
            IF user_input_patient_id IS NOT NULL THEN
              patient_cursor := rehab_center.CHECK_PATIENT_STATUS(user_input_patient_id);
              FETCH patient_cursor INTO patient_info;
              IF patient_info.patient_id IS NOT NULL THEN
                  DBMS_OUTPUT.put_line('Patient id is ' || patient_info.patient_id || 
                  ' ,Patient name is ' || patient_info.patient_first_name ||
                  ' and health insurance id is ' || patient_info.PATIENT_HEALTH_INSURANCE_NO
                  );
              ELSE 
                  DBMS_OUTPUT.put_line('Patient details are not found, Now we procede to register!');
                  DBMS_OUTPUT.put_line('------------------------------------------------------------');
                  patient_id := rehab_center.REGISTER_NEW_PATIENT();
                  DBMS_OUTPUT.put_line('Registered patient id is :' || patient_id);
              END IF;
              CLOSE patient_cursor;
            END IF;  
          END;

          WHEN user_input = 2 THEN 
            DBMS_OUTPUT.put_line('---------------------------Appointment for patients--------------------------------');
            declare
              patient_id rehab_center.Physio_patients.patient_id%TYPE;
              appointment_info SYS_REFCURSOR;
              appointment_records rehab_center.appointment%ROWTYPE;
            BEGIN
              appointment_info := rehab_center.MAKE_APPOINTMENT(user_input_patient_id);
              LOOP
                FETCH appointment_info INTO appointment_records;
                EXIT WHEN appointment_info%NOTFOUND;
                DBMS_OUTPUT.put_line('Appointment id is :' || appointment_records.appointment_no || ' Patient id is : ' || appointment_records.patient_id || ' and Appointment date is : ' ||  appointment_records.appointment_date_time);
              END LOOP;
              CLOSE appointment_info;
            END;
          WHEN user_input = 3 THEN 
            DBMS_OUTPUT.put_line('-----------------------------Appointments only patient can book---------------------------------');
            declare
              patient_id rehab_center.Physio_patients.patient_id%TYPE;
              appointment_info SYS_REFCURSOR;
              appointment_records rehab_center.appointment%ROWTYPE;
            BEGIN
              appointment_info := rehab_center.APPOINTMENT_BOOK_ONLYFOR_PATIENTS(user_input_patient_id);
              LOOP
                FETCH appointment_info INTO appointment_records;
                EXIT WHEN appointment_info%NOTFOUND;
                DBMS_OUTPUT.put_line('Appointment id is :' || appointment_records.appointment_no || ' Patient id is : ' || appointment_records.patient_id || ' and Appointment date is : ' ||  appointment_records.appointment_date_time);
              END LOOP;
              CLOSE appointment_info;
            END;
            WHEN user_input = 4 THEN 
            DBMS_OUTPUT.put_line('-----------------------------List of doctors---------------------------------');
            declare
              physio_doctor_cursor SYS_REFCURSOR;
              physio_doctor_info rehab_center.Physio_doctor%ROWTYPE;
            BEGIN
              physio_doctor_cursor := rehab_center.LIST_OF_DOCTORS();
              LOOP
                FETCH physio_doctor_cursor INTO physio_doctor_info;
                EXIT WHEN physio_doctor_cursor%NOTFOUND;
                DBMS_OUTPUT.put_line('Physio Doctor id :' || physio_doctor_info.PHYSIO_DOCTOR_ID || ' and first name is : ' || physio_doctor_info.PHYSIO_DOCTOR_FIRST_NAME || ' and center number is : ' ||  physio_doctor_info. PHYSIO_CENTER_NO);
              END LOOP;
              CLOSE physio_doctor_cursor;
            END;
            WHEN user_input = 5 THEN 
            DBMS_OUTPUT.put_line('-----------------------------Fetch doctors according to Id---------------------------------');
            declare
              physio_doctor_cursor SYS_REFCURSOR;
              physio_doctor_info rehab_center.Physio_doctor%ROWTYPE;
            BEGIN
              physio_doctor_cursor := rehab_center.DOCTOR_BY_ID(user_input_doctor_id);
              IF physio_doctor_cursor%FOUND THEN
                FETCH physio_doctor_cursor INTO physio_doctor_info;
                DBMS_OUTPUT.put_line('Physio Doctor id :' || physio_doctor_info.PHYSIO_DOCTOR_ID || ' and first name is : ' || physio_doctor_info.PHYSIO_DOCTOR_FIRST_NAME || ' and center number is : ' ||  physio_doctor_info. PHYSIO_CENTER_NO);
              ELSE 
                DBMS_OUTPUT.put_line('No Physio Doctor found for mention id!');
              END IF;  
              CLOSE physio_doctor_cursor;
            END;
    END CASE;    

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line('No data found');
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('An unexpected error occurred: ' || SQLERRM);    
END;
/
spool off;
