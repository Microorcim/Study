Attribute VB_Name = "InsertAdditionalData"
' Dopolnitelnoe zapolnenie tablic: Employee, Resident, MedicalProcedure, Payment, Visit
' Spravochniki dolzhny byt uzhe zapolneny (zapustite InsertNursingHomeData.InsertAllData snachala)
' VBA (Alt+F11): zapustite InsertMoreData (F5)

Option Compare Database
Option Explicit

Public Sub InsertMoreData()
    On Error GoTo Err_Insert
    Dim db As DAO.Database
    Set db = CurrentDb
    Dim s1$, s2$, s3$
    Dim maxEmp As Long, maxRes As Long, maxEmpNew As Long, maxResNew As Long
    Dim i As Integer

    ' Proverka: spravochniki dolzhny byt zapolneny (snachala zapustite InsertNursingHomeData.InsertAllData)
    If Nz(DCount("*", "Positions"), 0) = 0 Then
        MsgBox ChrW(1057) & ChrW(1085) & ChrW(1072) & ChrW(1095) & ChrW(1072) & ChrW(1083) & ChrW(1072) & " " & ChrW(1074) & ChrW(1099) & ChrW(1087) & ChrW(1086) & ChrW(1083) & ChrW(1085) & ChrW(1080) & ChrW(1090) & ChrW(1077) & " " & ChrW(73) & ChrW(110) & ChrW(115) & ChrW(101) & ChrW(114) & ChrW(116) & ChrW(78) & ChrW(117) & ChrW(114) & ChrW(115) & ChrW(105) & ChrW(110) & ChrW(103) & ChrW(72) & ChrW(111) & ChrW(109) & ChrW(101) & ChrW(68) & ChrW(97) & ChrW(116) & ChrW(97) & ChrW(46) & ChrW(73) & ChrW(110) & ChrW(115) & ChrW(101) & ChrW(114) & ChrW(116) & ChrW(65) & ChrW(108) & ChrW(108) & ChrW(68) & ChrW(97) & ChrW(116) & ChrW(97) & " " & ChrW(1076) & ChrW(1083) & ChrW(1103) & " " & ChrW(1089) & ChrW(1087) & ChrW(1088) & ChrW(1072) & ChrW(1074) & ChrW(1086) & ChrW(1095) & ChrW(1085) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ".", vbExclamation
        Exit Sub
    End If

    ' V Access pole schetchika chasto "ID" (s bolshoy bukvy)
    maxEmp = Nz(DMax("ID", "Employee"), 0)
    If maxEmp = 0 Then maxEmp = Nz(DMax("id", "Employee"), 0)
    maxRes = Nz(DMax("ID", "Resident"), 0)
    If maxRes = 0 Then maxRes = Nz(DMax("id", "Resident"), 0)

    ' === 1. Novye sotrudniki (position_id 1-6, work_schedule_id 1-5) ===
    s1 = ChrW(1043) & ChrW(1083) & ChrW(1077) & ChrW(1073) & ChrW(1086) & ChrW(1074): s2 = ChrW(1057) & ChrW(1090) & ChrW(1077) & ChrW(1087) & ChrW(1072) & ChrW(1085): s3 = ChrW(1048) & ChrW(1074) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1983-02-14#, 1, '+7-916-200-11-22', #2023-04-01#, 1)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074): s2 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1081): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1979-11-30#, 3, '+7-916-201-22-33', #2022-09-15#, 4)"
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1082) & ChrW(1072) & ChrW(1083) & ChrW(1077) & ChrW(1074) & ChrW(1072): s2 = ChrW(1042) & ChrW(1077) & ChrW(1088) & ChrW(1072): s3 = ChrW(1043) & ChrW(1077) & ChrW(1085) & ChrW(1085) & ChrW(1072) & ChrW(1076) & ChrW(1080) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1991-07-08#, 1, '+7-916-202-33-44', #2023-06-10#, 2)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1043) & ChrW(1088) & ChrW(1080) & ChrW(1075) & ChrW(1086) & ChrW(1088) & ChrW(1080) & ChrW(1081): s3 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1986-05-22#, 2, '+7-916-203-44-55', #2022-11-01#, 3)"
    s1 = ChrW(1055) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1051) & ChrW(1102) & ChrW(1073) & ChrW(1086) & ChrW(1074) & ChrW(1100): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1984-09-17#, 4, '+7-916-204-55-66', #2023-01-20#, 1)"

    maxEmpNew = Nz(DMax("ID", "Employee"), maxEmp + 5)
    If maxEmpNew = 0 Then maxEmpNew = Nz(DMax("id", "Employee"), maxEmp + 5)

    ' === 2. Novye zhilcy (room_id 1-10, health_status_id 1-5, gender_id 1-2) ===
    s1 = ChrW(1056) & ChrW(1091) & ChrW(1082) & ChrW(1086) & ChrW(1074): s2 = ChrW(1054) & ChrW(1083) & ChrW(1077) & ChrW(1073): s3 = ChrW(1048) & ChrW(1074) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1945-01-10#, #2023-09-01#, 1, 2, 1)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1053) & ChrW(1080) & ChrW(1085) & ChrW(1072): s3 = ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1936-04-25#, #2023-10-15#, 2, 4, 2)"
    s1 = ChrW(1057) & ChrW(1077) & ChrW(1084) & ChrW(1105) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1948-08-03#, #2023-11-01#, 4, 1, 1)"
    s1 = ChrW(1050) & ChrW(1088) & ChrW(1086) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1045) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1072): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1941-12-18#, #2023-08-20#, 5, 3, 2)"
    s1 = ChrW(1042) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1055) & ChrW(1072) & ChrW(1074) & ChrW(1077) & ChrW(1083): s3 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1937-06-09#, #2023-07-10#, 6, 2, 1)"
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1082) & ChrW(1080) & ChrW(1085) & ChrW(1072): s2 = ChrW(1048) & ChrW(1088) & ChrW(1080) & ChrW(1085) & ChrW(1072): s3 = ChrW(1048) & ChrW(1083) & ChrW(1100) & ChrW(1080) & ChrW(1085) & ChrW(1080) & ChrW(1095) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1951-03-14#, #2024-01-05#, 7, 1, 2)"
    s1 = ChrW(1044) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1092) & ChrW(1077) & ChrW(1077) & ChrW(1074): s2 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1080) & ChrW(1083): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1943-10-27#, #2023-12-01#, 9, 4, 1)"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1072): s2 = ChrW(1057) & ChrW(1086) & ChrW(1092) & ChrW(1100) & ChrW(1103): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1946-02-08#, #2024-02-10#, 10, 2, 2)"

    maxResNew = Nz(DMax("ID", "Resident"), maxRes + 8)
    If maxResNew = 0 Then maxResNew = Nz(DMax("id", "Resident"), maxRes + 8)

    ' === 3. Medicinskie procedury (procedure_type 1-7, employee 1..maxEmpNew, resident 1..maxResNew) ===
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-03-01 09:00#, " & maxEmpNew & ", " & maxResNew - 1 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-03-02 10:00#, " & maxEmpNew - 1 & ", " & maxResNew & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-03-03 09:30#, " & maxEmpNew - 2 & ", " & maxResNew - 2 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (3, #2024-03-04 11:00#, " & maxEmpNew - 3 & ", " & maxResNew - 3 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (6, #2024-03-05 08:00#, " & maxEmpNew - 4 & ", " & maxResNew - 4 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-03-06 09:00#, 1, " & maxResNew & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (4, #2024-03-07 14:00#, 2, " & maxResNew - 1 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (7, #2024-03-08 10:00#, " & maxEmpNew & ", " & maxResNew - 5 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-03-10 09:00#, " & maxEmpNew & ", " & maxResNew - 6 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (5, #2024-03-12 11:00#, 1, " & maxResNew - 7 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-03-15 09:00#, " & maxEmpNew - 1 & ", " & maxResNew - 2 & ")"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-03-18 10:30#, " & maxEmpNew - 2 & ", " & maxResNew & ")"

    ' === 4. Platezhi (payment_method 1-5, resident 1..maxResNew) ===
    For i = maxRes + 1 To maxResNew
        db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-01#, 45000, 3, " & i & ")"
    Next i
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-05#, 46000, 2, " & maxResNew & ")"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-05#, 45000, 4, " & maxResNew - 1 & ")"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-10#, 47000, 3, " & maxResNew - 2 & ")"

    ' === 5. Poseweniya (relationship_type 1-7, resident 1..maxResNew) ===
    s1 = ChrW(1056) & ChrW(1091) & ChrW(1082) & ChrW(1086) & ChrW(1074) & " " & ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-03-02 14:00#, " & maxResNew & ")"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074) & " " & ChrW(1042) & ChrW(1077) & ChrW(1088) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-03-03 11:00#, " & maxResNew - 1 & ")"
    s1 = ChrW(1057) & ChrW(1077) & ChrW(1084) & ChrW(1105) & ChrW(1085) & ChrW(1086) & ChrW(1074) & " " & ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-03-05 16:00#, " & maxResNew - 2 & ")"
    s1 = ChrW(1050) & ChrW(1088) & ChrW(1086) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-03-06 10:00#, " & maxResNew - 3 & ")"
    s1 = ChrW(1042) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074) & " " & ChrW(1048) & ChrW(1088) & ChrW(1080) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-03-08 13:00#, " & maxResNew - 4 & ")"
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1082) & ChrW(1080) & ChrW(1085) & ChrW(1072) & " " & ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-03-10 15:00#, " & maxResNew - 5 & ")"
    s1 = ChrW(1044) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1092) & ChrW(1077) & ChrW(1077) & ChrW(1074) & " " & ChrW(1045) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-03-12 11:00#, " & maxResNew - 6 & ")"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1072) & " " & ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-03-15 14:00#, " & maxResNew - 7 & ")"
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & ChrW(1058) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1072) & " " & ChrW(1057) & ChrW(1086) & ChrW(1092) & ChrW(1100) & ChrW(1103) & "', 4, #2024-03-18 12:00#, " & maxResNew & ")"

    MsgBox ChrW(1044) & ChrW(1086) & ChrW(1087) & ChrW(1086) & ChrW(1083) & ChrW(1085) & ChrW(1080) & ChrW(1090) & ChrW(1077) & ChrW(1083) & ChrW(1100) & ChrW(1085) & ChrW(1086) & " " & ChrW(1076) & ChrW(1086) & ChrW(1073) & ChrW(1072) & ChrW(1074) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1086) & " " & ChrW(1076) & ChrW(1072) & ChrW(1085) & ChrW(1085) & ChrW(1099) & ChrW(1093) & ".", vbInformation
    Exit Sub

Err_Insert:
    MsgBox ChrW(1054) & ChrW(1096) & ChrW(1080) & ChrW(1073) & ChrW(1082) & ChrW(1072) & ": " & Err.Description & " (" & ChrW(1082) & ChrW(1086) & ChrW(1076) & " " & Err.Number & ")", vbCritical
End Sub
