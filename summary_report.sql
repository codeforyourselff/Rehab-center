connect rehab_center/123;
SET WRAP OFF;
SET LINESIZE 200;

SPOOL rehab_center_report.txt;

-- 2. List of patients who didn't take the treatments and those equipment not used.
-- SELECT e.equipment_id,e.equipment_name,t.treatment_id,t.patient_id,t.treatment_type,p.patient_first_name FROM EQUIPMENT e LEFT JOIN Treatment t ON t.treatment_id = e.treatment_id LEFT JOIN Physio_patients p ON p.patient_id = t.treatment_id WHERE t.patient_id IS NULL;

SELECT 
    e.equipment_id,
    e.equipment_name,
    t.treatment_id,
    t.patient_id,
    t.treatment_type,
    p.patient_first_name
FROM 
    EQUIPMENT e
LEFT JOIN 
    Treatment t ON t.treatment_id = e.treatment_id
LEFT JOIN 
    Physio_patients p ON p.patient_id = t.patient_id
WHERE 
    t.patient_id IS NULL;


-- 3. List all information available for physio patients who have been at the center.(considered here center no is 1)

SELECT 
    p.patient_id,
    p.patient_first_name,
    p.email_id,
    p.patient_health_insurance_no,
    p.birthdate,
    p.gender,
    a.appointment_date_time,
    cpm.physio_center_no
FROM 
    Physio_patients p
LEFT JOIN 
    Appointment a ON a.patient_id = p.patient_id
INNER JOIN 
    center_patient_mapping cpm ON p.patient_id = cpm.patient_id
WHERE 
    a.appointment_date_time < SYSDATE 
    AND cpm.Physio_center_no = 1 
    AND a.Physio_doctor_id IS NOT NULL;


--4. List all the information available for therapists who have been at the center.

    SELECT 
        PHYSIO_THERAPIST_FIRST_NAME,
        PHYSIO_THERAPIST_LAST_NAME,
        PHYSIO_THERAPIST_EXPERIENCE,
        PHYSIO_CENTER_NO
    FROM 
        Physio_therapist p
    WHERE p.physio_center_no = 1 And p.physio_therapist_availibilty = 'Available';

--5. List all the information available for therapists who work at the center.

    SELECT 
        PHYSIO_THERAPIST_FIRST_NAME,
        PHYSIO_THERAPIST_LAST_NAME,
        PHYSIO_THERAPIST_EXPERIENCE,
        PHYSIO_CENTER_NO
    FROM 
        Physio_therapist p
    WHERE p.physio_center_no = 1 And p.physio_therapist_availibilty = 'Available';

--6. List detail of reservations for a specific patient
    SELECT 
        p.patient_first_name,
        p.patient_last_name,
        p.birthdate,
        p.patient_health_insurance_no,
        ap.appointment_date_time,
        pd.physio_doctor_first_name,
        t.treatment_type,
        t.physio_therapist_id,
        e.equipment_name
    FROM 
        Physio_patients p
    LEFT JOIN
        Appointment ap
    ON ap.patient_id = p.patient_id 
    LEFT JOIN
        Physio_doctor pd 
    ON ap.physio_doctor_id = pd.physio_doctor_id 
    LEFT JOIN
        Treatment t
    ON t.patient_id = p.patient_id    
    LEFT JOIN
        Equipment e
    ON e.treatment_id = t.treatment_id
    WHERE p.patient_id  = 2;

--7. List availability for physio therapist/doctor during a specified period of time

    SELECT 
        pd.physio_doctor_first_name,
        pd.physio_doctor_last_name,
        pd.physio_doctor_experience,
        pd.physio_center_no,
        pda.Physio_doctor_availibility_date,
        pda.Physio_doctor_availibility_status,
        pda.Physio_doctor_availibility_start_time,
        pda.Physio_doctor_availibility_end_time
    FROM 
        Physio_doctor pd
    INNER JOIN 
        Physio_doctor_availibilty pda
    ON  pd.physio_doctor_id = pda.physio_doctor_id
    WHERE pda.Physio_doctor_availibility_date < SYSDATE;

SPOOL OFF;