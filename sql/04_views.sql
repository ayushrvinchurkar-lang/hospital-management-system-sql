USE HospitalDB;

-- View 1: Patient Bill Summary

CREATE OR REPLACE VIEW PatientBillSummary AS
SELECT
    P.PatientID,
    CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
    COUNT(B.BillID) AS NumberOfBills,
    SUM(B.Amount) AS TotalSpent
FROM Patients P
JOIN Bills B
    ON P.PatientID = B.PatientID
GROUP BY
    P.PatientID,
    P.FirstName,
    P.LastName;

SELECT * FROM PatientBillSummary;

-- View 2: Monthly Appointment Trend

CREATE OR REPLACE VIEW MonthlyAppointmentTrend AS
SELECT
    YEAR(AppointmentDate) AS AppointmentYear,
    MONTH(AppointmentDate) AS AppointmentMonth,
    MONTHNAME(AppointmentDate) AS MonthName,
    COUNT(AppointmentID) AS TotalAppointments
FROM Appointments
GROUP BY
    YEAR(AppointmentDate),
    MONTH(AppointmentDate),
    MONTHNAME(AppointmentDate)
ORDER BY
    AppointmentYear,
    AppointmentMonth;

SELECT * FROM MonthlyAppointmentTrend;
