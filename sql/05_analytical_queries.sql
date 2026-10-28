USE HospitalDB;

-- Which doctor handled the most appointments?  

SELECT
    D.DoctorID,
    D.DoctorName,
    D.Specialization,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM Doctors D
JOIN Appointments A
    ON D.DoctorID = A.DoctorID
GROUP BY
    D.DoctorID,
    D.DoctorName,
    D.Specialization
ORDER BY TotalAppointments DESC;

-- How can patients be classified based on their total medical spending?

SELECT
    P.PatientID,
    CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
    SUM(B.Amount) AS TotalSpent,
    CASE
        WHEN SUM(B.Amount) >= 3000 THEN 'High Spender'
        WHEN SUM(B.Amount) >= 1000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory
FROM Patients P
JOIN Bills B
    ON P.PatientID = B.PatientID
GROUP BY
    P.PatientID,
    P.FirstName,
    P.LastName
ORDER BY TotalSpent DESC;

-- Which treatments generate the highest revenue?
-- NOTE: This original query joins patient-level bills to treatments by patient.
-- If a patient has multiple treatments or bills, bill amounts may be duplicated across treatments.
-- Interpret cautiously; a production schema should link each bill line to the specific treatment.

SELECT
    T.TreatmentID,
    T.TreatmentName,
    SUM(B.Amount) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(B.Amount) DESC) AS RevenueRank
FROM Treatments T
JOIN PatientTreatments PT
    ON T.TreatmentID = PT.TreatmentID
JOIN Bills B
    ON PT.PatientID = B.PatientID
GROUP BY
    T.TreatmentID,
    T.TreatmentName;
