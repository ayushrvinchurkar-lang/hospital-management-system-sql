USE HospitalDB;

-- Verify the tables and sample records.
SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Treatments;
SELECT * FROM PatientTreatments;
SELECT * FROM Bills;

-- Appointments with patient and doctor names.
SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    a.AppointmentDate,
    a.AppointmentTime,
    d.DoctorName,
    a.Status
FROM Patients AS p
INNER JOIN Appointments AS a
    ON p.PatientID = a.PatientID
INNER JOIN Doctors AS d
    ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate;
