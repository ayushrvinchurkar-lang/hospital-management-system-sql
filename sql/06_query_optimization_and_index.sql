USE HospitalDB;

-- Slow query

SELECT
    P.PatientID,
    CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
    (
        SELECT SUM(B.Amount)
        FROM Bills B
        WHERE B.PatientID = P.PatientID
    ) AS TotalSpent
FROM Patients P;

-- Improved query

SELECT
    P.PatientID,
    CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
    SUM(B.Amount) AS TotalSpent
FROM Patients P
JOIN Bills B
    ON P.PatientID = B.PatientID
GROUP BY
    P.PatientID,
    P.FirstName,
    P.LastName;
    
    -- Added index
    
    CREATE INDEX idx_bills_patientid
ON Bills(PatientID);
SHOW INDEX FROM Bills;
