CONNECT sys as sysdba;
-- connect rehab_center/123;
SPOOL rehab_center_users_information.txt;

DROP USER c##receptionist CASCADE;
DROP USER c##doctor CASCADE;
DROP USER c##patient CASCADE;

CREATE USER c##receptionist IDENTIFIED BY Res123;
CREATE USER c##doctor IDENTIFIED BY Doc123;
CREATE USER c##patient IDENTIFIED BY Pat123;

GRANT CONNECT TO c##patient;
GRANT SELECT, INSERT ON rehab_center.Appointment TO c##patient;
GRANT EXECUTE ON rehab_center.CHECK_PATIENT_STATUS TO c##patient;

GRANT CONNECT TO c##doctor;
GRANT SELECT, INSERT, UPDATE, ALTER ON rehab_center.Physio_doctor TO c##doctor;
GRANT SELECT ON rehab_center.Physio_patients TO c##doctor;

GRANT CONNECT, RESOURCE TO c##receptionist;
GRANT DBA TO c##receptionist;

SPOOL OFF;
