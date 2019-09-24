SELECT
  p.name,
  ph.name
FROM
  Patient p,
  Physician ph
WHERE
  p.PCP = ph.EmployeeID
  and ph.EmployeeID not in (
    SELECT
      head
    from
      Department
  );
-- 2 ------
SELECT
  Patient.name patient,
  Physician.name physician,
  COUNT(Appointment.Patient) appointments
FROM
  (
    (
      (
        Appointment
        INNER JOIN Physician ON Appointment.Physician = Physician.EmployeeID
      )
      INNER JOIN Patient ON Appointment.Patient = Patient.SSN
    )
    INNER JOIN Nurse ON Appointment.PrepNurse = Nurse.EmployeeID
  )
WHERE
  Nurse.Registered = 1
GROUP BY
  Appointment.Patient,
  Appointment.Physician
HAVING
  COUNT(Appointment.Patient) >= 2;
-- 3 -----
SELECT
  p.name patient,
  ph.name physician,
  pr.cost procedure_cost
FROM
  (
    (
      (
        Undergoes u
        INNER JOIN Physician ph ON u.physician = ph.EmployeeID
      )
      INNER JOIN Patient p ON u.Patient = p.SSN
    )
    INNER JOIN Procedures pr ON u.Procedures = pr.code
  )
WHERE
  pr.cost > 5000;
-- 4 ----
SELECT
  p.name patient,
  ph.name physician,
  u.DateUndergoes procedure_date,
  pr.name proc_name,
  ph.Position physician_position,
  t.CertificationExpires
FROM
  (
    (
      (
        Undergoes u
        INNER JOIN (
          Physician ph
          INNER JOIN Trained_In t ON ph.EmployeeID = t.physician
        ) ON u.physician = ph.EmployeeID
      )
      INNER JOIN Patient p ON u.Patient = p.SSN
    )
    INNER JOIN Procedures pr ON u.Procedures = pr.code
  )
WHERE
  u.DateUndergoes > t.CertificationExpires;
-- 5 ---