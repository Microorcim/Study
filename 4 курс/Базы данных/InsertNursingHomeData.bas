Attribute VB_Name = "InsertNursingHomeData"
' Modul zapolneniya BD "Dom Pristarelyh"
' V redaktore VBA (Alt+F11): zapustite proceduru InsertAllData (F5)
' Russkiy tekst vynesen v ChrW() dlya korrektnoy raboty v Access (kodirovka)

Option Compare Database
Option Explicit

Public Sub InsertAllData()
    On Error GoTo Err_Insert
    Dim db As DAO.Database
    Set db = CurrentDb
    Dim s1$, s2$, s3$
    ' Ubedites, chto otkryt nuzhnyy fayl .accdb (imya pokazano v nachale)
    MsgBox ChrW(1047) & ChrW(1072) & ChrW(1087) & ChrW(1086) & ChrW(1083) & ChrW(1085) & ChrW(1103) & ChrW(1077) & ChrW(1084) & " " & ChrW(1073) & ChrW(1072) & ChrW(1079) & ChrW(1091) & ": " & db.Name, vbInformation
    ' 1. Spravochniki - ProcedureType (1048=I 1079=z 1084=m 1077=e 1088=r 1077=e 1085=n 1080=i 1077=e 32=sp 1076=d 1072=a 1074=v 1083=l 1077=e 1085=n 1080=i 1103=ya)
    s1 = ChrW(1048) & ChrW(1079) & ChrW(1084) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1077) & " " & ChrW(1076) & ChrW(1072) & ChrW(1074) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1103)
    s2 = ChrW(1050) & ChrW(1086) & ChrW(1085) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1083) & ChrW(1100) & " " & ChrW(1072) & ChrW(1088) & ChrW(1090) & ChrW(1077) & ChrW(1088) & ChrW(1080) & ChrW(1072) & ChrW(1083) & ChrW(1100) & ChrW(1085) & ChrW(1086) & ChrW(1075) & ChrW(1086) & " " & ChrW(1076) & ChrW(1072) & ChrW(1074) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1103)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1048) & ChrW(1085) & ChrW(1100) & ChrW(1077) & ChrW(1082) & ChrW(1094) & ChrW(1080) & ChrW(1103)
    s2 = ChrW(1042) & ChrW(1085) & ChrW(1091) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1084) & ChrW(1099) & ChrW(1096) & ChrW(1077) & ChrW(1095) & ChrW(1085) & ChrW(1099) & ChrW(1077) & " " & ChrW(1080) & ChrW(1085) & ChrW(1076) & ChrW(1086) & ChrW(1082) & ChrW(1086) & ChrW(1078) & ChrW(1085) & ChrW(1099) & ChrW(1077) & " " & ChrW(1080) & ChrW(1085) & ChrW(1100) & ChrW(1077) & ChrW(1082) & ChrW(1094) & ChrW(1080) & ChrW(1080)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1089) & ChrW(1089) & ChrW(1072) & ChrW(1078)
    s2 = ChrW(1051) & ChrW(1077) & ChrW(1095) & ChrW(1077) & ChrW(1073) & ChrW(1085) & ChrW(1099) & ChrW(1081) & " " & ChrW(1084) & ChrW(1072) & ChrW(1089) & ChrW(1089) & ChrW(1072) & ChrW(1078) & " " & ChrW(1076) & ChrW(1083) & ChrW(1103) & " " & ChrW(1091) & ChrW(1083) & ChrW(1091) & ChrW(1095) & ChrW(1096) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1103) & " " & ChrW(1082) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1086) & ChrW(1086) & ChrW(1073) & ChrW(1088) & ChrW(1072) & ChrW(1097) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1103)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1060) & ChrW(1080) & ChrW(1079) & ChrW(1080) & ChrW(1086) & ChrW(1090) & ChrW(1077) & ChrW(1088) & ChrW(1072) & ChrW(1087) & ChrW(1080) & ChrW(1103)
    s2 = ChrW(1069) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1092) & ChrW(1086) & ChrW(1088) & ChrW(1077) & ChrW(1079) & ", " & ChrW(1059) & ChrW(1042) & ChrW(1063) & " " & ChrW(1080) & ChrW(1076) & ChrW(1088) & ChrW(1091) & ChrW(1075) & ChrW(1080) & ChrW(1077) & " " & ChrW(1087) & ChrW(1088) & ChrW(1086) & ChrW(1094) & ChrW(1077) & ChrW(1076) & ChrW(1091) & ChrW(1088) & ChrW(1099)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1055) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1074) & ChrW(1103) & ChrW(1079) & ChrW(1082) & ChrW(1072)
    s2 = ChrW(1054) & ChrW(1073) & ChrW(1088) & ChrW(1072) & ChrW(1073) & ChrW(1086) & ChrW(1090) & ChrW(1082) & ChrW(1072) & " " & ChrW(1080) & ChrW(1076) & ChrW(1087) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1074) & ChrW(1103) & ChrW(1079) & ChrW(1082) & ChrW(1072) & " " & ChrW(1088) & ChrW(1072) & ChrW(1085)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1048) & ChrW(1079) & ChrW(1084) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1077) & " " & ChrW(1087) & ChrW(1083) & ChrW(1086) & ChrW(1074) & ChrW(1086) & ChrW(1082) & ChrW(1086) & ChrW(1081) & ChrW(1075) & ChrW(1083) & ChrW(1091) & ChrW(1079) & ChrW(1099)
    s2 = ChrW(1050) & ChrW(1086) & ChrW(1085) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1083) & ChrW(1100) & " " & ChrW(1089) & ChrW(1072) & ChrW(1093) & ChrW(1072) & ChrW(1088) & ChrW(1072) & ChrW(1074) & ChrW(1082) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    s1 = ChrW(1055) & ChrW(1088) & ChrW(1080) & ChrW(1077) & ChrW(1084) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1072) & ChrW(1088) & ChrW(1089) & ChrW(1090) & ChrW(1074) & ChrW(1086)
    s2 = ChrW(1055) & ChrW(1088) & ChrW(1086) & ChrW(1087) & ChrW(1080) & ChrW(1090) & ChrW(1072) & ChrW(1085) & ChrW(1080) & ChrW(1077) & " " & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1072) & ChrW(1088) & ChrW(1089) & ChrW(1090) & ChrW(1074)
    db.Execute "INSERT INTO ProcedureType (procedure_name, description) VALUES ('" & s1 & "', '" & s2 & "')", dbFailOnError
    
    db.Execute "INSERT INTO PaymentMethod (method_name) VALUES ('" & ChrW(1053) & ChrW(1072) & ChrW(1083) & ChrW(1080) & ChrW(1095) & ChrW(1085) & ChrW(1099) & ChrW(1077) & "')"
    db.Execute "INSERT INTO PaymentMethod (method_name) VALUES ('" & ChrW(1041) & ChrW(1072) & ChrW(1085) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1089) & ChrW(1082) & ChrW(1072) & ChrW(1103) & " " & ChrW(1082) & ChrW(1072) & ChrW(1088) & ChrW(1090) & ChrW(1072) & "')"
    db.Execute "INSERT INTO PaymentMethod (method_name) VALUES ('" & ChrW(1041) & ChrW(1077) & ChrW(1079) & ChrW(1085) & ChrW(1072) & ChrW(1083) & ChrW(1080) & ChrW(1095) & ChrW(1085) & ChrW(1099) & ChrW(1081) & " " & ChrW(1087) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1074) & ChrW(1086) & ChrW(1076) & "')"
    db.Execute "INSERT INTO PaymentMethod (method_name) VALUES ('" & ChrW(1057) & ChrW(1086) & ChrW(1094) & ChrW(1080) & ChrW(1072) & ChrW(1083) & ChrW(1100) & ChrW(1085) & ChrW(1099) & ChrW(1077) & " " & ChrW(1074) & ChrW(1099) & ChrW(1087) & ChrW(1083) & ChrW(1072) & ChrW(1090) & ChrW(1099) & "')"
    db.Execute "INSERT INTO PaymentMethod (method_name) VALUES ('" & ChrW(1050) & ChrW(1088) & ChrW(1077) & ChrW(1076) & ChrW(1080) & ChrW(1090) & ChrW(1085) & ChrW(1072) & ChrW(1103) & " " & ChrW(1082) & ChrW(1072) & ChrW(1088) & ChrW(1090) & ChrW(1072) & "')"
    
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1057) & ChrW(1099) & ChrW(1085) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1044) & ChrW(1086) & ChrW(1095) & ChrW(1100) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1042) & ChrW(1085) & ChrW(1091) & ChrW(1082) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1042) & ChrW(1085) & ChrW(1091) & ChrW(1095) & ChrW(1082) & ChrW(1072) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1041) & ChrW(1088) & ChrW(1072) & ChrW(1090) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1057) & ChrW(1077) & ChrW(1089) & ChrW(1090) & ChrW(1088) & ChrW(1072) & "')"
    db.Execute "INSERT INTO RelationshipType (relationship_name) VALUES ('" & ChrW(1044) & ChrW(1088) & ChrW(1091) & ChrW(1075) & " " & ChrW(1089) & ChrW(1077) & ChrW(1084) & ChrW(1100) & ChrW(1080) & "')"
    
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1052) & ChrW(1077) & ChrW(1076) & ChrW(1089) & ChrW(1077) & ChrW(1089) & ChrW(1090) & ChrW(1088) & ChrW(1072) & "')"
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1057) & ChrW(1072) & ChrW(1085) & ChrW(1080) & ChrW(1090) & ChrW(1072) & ChrW(1088) & "')"
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1042) & ChrW(1088) & ChrW(1072) & ChrW(1095) & ChrW(45) & ChrW(1090) & ChrW(1077) & ChrW(1088) & ChrW(1072) & ChrW(1087) & ChrW(1077) & ChrW(1074) & ChrW(1090) & "')"
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1057) & ChrW(1080) & ChrW(1076) & ChrW(1077) & ChrW(1083) & ChrW(1082) & ChrW(1072) & "')"
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1040) & ChrW(1076) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1080) & ChrW(1089) & ChrW(1090) & ChrW(1088) & ChrW(1072) & ChrW(1090) & ChrW(1086) & ChrW(1088) & "')"
    db.Execute "INSERT INTO Positions (position_name) VALUES ('" & ChrW(1060) & ChrW(1080) & ChrW(1079) & ChrW(1080) & ChrW(1086) & ChrW(1090) & ChrW(1077) & ChrW(1088) & ChrW(1072) & ChrW(1087) & ChrW(1077) & ChrW(1074) & ChrW(1090) & "')"
    
    s1 = ChrW(1044) & ChrW(1085) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072) & ChrW(1103) & " " & ChrW(1089) & ChrW(1084) & ChrW(1077) & ChrW(1085) & ChrW(1072) & " (8:00-20:00)"
    db.Execute "INSERT INTO WorkSchedule (schedule_name) VALUES ('" & s1 & "')"
    s1 = ChrW(1053) & ChrW(1086) & ChrW(1095) & ChrW(1085) & ChrW(1072) & ChrW(1103) & " " & ChrW(1089) & ChrW(1084) & ChrW(1077) & ChrW(1085) & ChrW(1072) & " (20:00-8:00)"
    db.Execute "INSERT INTO WorkSchedule (schedule_name) VALUES ('" & s1 & "')"
    db.Execute "INSERT INTO WorkSchedule (schedule_name) VALUES ('" & ChrW(1057) & ChrW(1084) & ChrW(1077) & ChrW(1085) & ChrW(1085) & ChrW(1099) & ChrW(1081) & " " & ChrW(1075) & ChrW(1088) & ChrW(1072) & ChrW(1092) & ChrW(1080) & ChrW(1082) & " 2/2" & "')"
    db.Execute "INSERT INTO WorkSchedule (schedule_name) VALUES ('" & ChrW(1055) & ChrW(1103) & ChrW(1090) & ChrW(1080) & ChrW(1076) & ChrW(1085) & ChrW(1077) & ChrW(1074) & ChrW(1082) & ChrW(1072) & " (9:00-18:00)" & "')"
    db.Execute "INSERT INTO WorkSchedule (schedule_name) VALUES ('" & ChrW(1043) & ChrW(1080) & ChrW(1073) & ChrW(1082) & ChrW(1080) & ChrW(1076) & ChrW(1085) & ChrW(1077) & ChrW(1074) & ChrW(1082) & ChrW(1072) & "')"
    
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('101', 1, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('102', 1, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('103', 1, 1)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('201', 2, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('202', 2, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('301', 3, 1)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('104', 1, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('203', 2, 1)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('302', 3, 2)"
    db.Execute "INSERT INTO Room (room_number, floor, capacity) VALUES ('303', 3, 1)"
    
    db.Execute "INSERT INTO HealthStatus (status_name) VALUES ('" & ChrW(1059) & ChrW(1076) & ChrW(1086) & ChrW(1074) & ChrW(1083) & ChrW(1077) & ChrW(1090) & ChrW(1074) & ChrW(1086) & ChrW(1088) & ChrW(1080) & ChrW(1090) & ChrW(1077) & ChrW(1083) & ChrW(1100) & ChrW(1085) & ChrW(1086) & ChrW(1077) & "')"
    db.Execute "INSERT INTO HealthStatus (status_name) VALUES ('" & ChrW(1057) & ChrW(1088) & ChrW(1077) & ChrW(1076) & ChrW(1085) & ChrW(1077) & ChrW(1081) & " " & ChrW(1090) & ChrW(1103) & ChrW(1078) & ChrW(1077) & ChrW(1089) & ChrW(1090) & ChrW(1080) & "')"
    db.Execute "INSERT INTO HealthStatus (status_name) VALUES ('" & ChrW(1058) & ChrW(1088) & ChrW(1077) & ChrW(1073) & ChrW(1091) & ChrW(1077) & ChrW(1090) & ChrW(1089) & ChrW(1103) & " " & ChrW(1087) & ChrW(1086) & ChrW(1089) & ChrW(1090) & ChrW(1086) & ChrW(1103) & ChrW(1085) & ChrW(1085) & ChrW(1099) & ChrW(1081) & " " & ChrW(1091) & ChrW(1093) & ChrW(1086) & ChrW(1076) & "')"
    db.Execute "INSERT INTO HealthStatus (status_name) VALUES ('" & ChrW(1057) & ChrW(1090) & ChrW(1072) & ChrW(1073) & ChrW(1080) & ChrW(1083) & ChrW(1100) & ChrW(1085) & ChrW(1086) & ChrW(1077) & "')"
    db.Execute "INSERT INTO HealthStatus (status_name) VALUES ('" & ChrW(1054) & ChrW(1089) & ChrW(1083) & ChrW(1086) & ChrW(1078) & ChrW(1085) & ChrW(1077) & ChrW(1085) & ChrW(1085) & ChrW(1086) & ChrW(1077) & "')"
    
    db.Execute "INSERT INTO Gender (gender_name) VALUES ('" & ChrW(1052) & ChrW(1091) & ChrW(1078) & ChrW(1089) & ChrW(1082) & ChrW(1086) & ChrW(1081) & "')"
    db.Execute "INSERT INTO Gender (gender_name) VALUES ('" & ChrW(1046) & ChrW(1077) & ChrW(1085) & ChrW(1089) & ChrW(1082) & ChrW(1086) & ChrW(1081) & "')"
    
    ' 2. Sotrudniki
    s1 = ChrW(1048) & ChrW(1074) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1080) & ChrW(1103): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1985-03-15#, 1, '+7-916-111-22-33', #2020-01-10#, 1)"
    s1 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074): s2 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1077) & ChrW(1081): s3 = ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1978-07-22#, 3, '+7-916-222-33-44', #2019-06-01#, 4)"
    s1 = ChrW(1057) & ChrW(1080) & ChrW(1076) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1045) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1072): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1990-11-08#, 1, '+7-916-333-44-55', #2021-03-15#, 2)"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1079) & ChrW(1083) & ChrW(1086) & ChrW(1074): s2 = ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1081): s3 = ChrW(1048) & ChrW(1074) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1982-01-30#, 2, '+7-916-444-55-66', #2020-09-01#, 3)"
    s1 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1077) & ChrW(1074) & ChrW(1072): s2 = ChrW(1054) & ChrW(1083) & ChrW(1100) & ChrW(1075) & ChrW(1072): s3 = ChrW(1040) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1975-05-12#, 4, '+7-916-555-66-77', #2018-02-20#, 1)"
    s1 = ChrW(1052) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1079) & ChrW(1086) & ChrW(1074): s2 = ChrW(1048) & ChrW(1075) & ChrW(1086) & ChrW(1088) & ChrW(1100)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', NULL, #1988-09-25#, 5, '+7-916-666-77-88', #2022-01-05#, 4)"
    s1 = ChrW(1042) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074): s2 = ChrW(1040) & ChrW(1085) & ChrW(1085) & ChrW(1072): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1987-04-18#, 1, '+7-916-777-88-99', #2021-07-01#, 1)"
    s1 = ChrW(1057) & ChrW(1086) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1086) & ChrW(1074): s2 = ChrW(1055) & ChrW(1072) & ChrW(1074) & ChrW(1077) & ChrW(1083): s3 = ChrW(1048) & ChrW(1083) & ChrW(1100) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1980-12-05#, 2, '+7-916-888-99-00', #2019-11-15#, 3)"
    s1 = ChrW(1041) & ChrW(1077) & ChrW(1088) & ChrW(1077) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1072): s2 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1080) & ChrW(1103): s3 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1992-06-20#, 6, '+7-916-999-00-11', #2023-02-10#, 4)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1080) & ChrW(1083): s3 = ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1976-09-08#, 4, '+7-916-100-11-22', #2017-05-20#, 5)"
    
    ' 3. Zhilcy
    s1 = ChrW(1057) & ChrW(1084) & ChrW(1080) & ChrW(1088) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1081): s3 = ChrW(1060) & ChrW(1105) & ChrW(1076) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1940-04-20#, #2021-05-10#, 1, 1, 1)"
    s1 = ChrW(1050) & ChrW(1091) & ChrW(1079) & ChrW(1085) & ChrW(1077) & ChrW(1094) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1040) & ChrW(1085) & ChrW(1085) & ChrW(1072): s3 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1081) & ChrW(1083) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1938-08-15#, #2020-11-01#, 1, 2, 2)"
    s1 = ChrW(1055) & ChrW(1086) & ChrW(1087) & ChrW(1086) & ChrW(1074): s2 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088): s3 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1945-12-03#, #2022-02-20#, 2, 4, 1)"
    s1 = ChrW(1042) & ChrW(1072) & ChrW(1089) & ChrW(1080) & ChrW(1083) & ChrW(1100) & ChrW(1077) & ChrW(1074) & ChrW(1072): s2 = ChrW(1043) & ChrW(1072) & ChrW(1083) & ChrW(1080) & ChrW(1085) & ChrW(1072): s3 = ChrW(1048) & ChrW(1074) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1942-06-28#, #2021-08-15#, 2, 1, 2)"
    s1 = ChrW(1060) & ChrW(1105) & ChrW(1076) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074): s2 = ChrW(1041) & ChrW(1086) & ChrW(1088) & ChrW(1080) & ChrW(1089): s3 = ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1936-02-14#, #2019-03-01#, 3, 3, 1)"
    s1 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1081) & ChrW(1083) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1058) & ChrW(1072) & ChrW(1090) & ChrW(1100) & ChrW(1103) & ChrW(1085) & ChrW(1072): s3 = ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1948-10-09#, #2022-06-01#, 4, 2, 2)"
    s1 = ChrW(1053) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074): s2 = ChrW(1045) & ChrW(1074) & ChrW(1075) & ChrW(1077) & ChrW(1085) & ChrW(1080) & ChrW(1081): s3 = ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1943-07-17#, #2020-04-12#, 4, 4, 1)"
    s1 = ChrW(1042) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1051) & ChrW(1080) & ChrW(1076) & ChrW(1080) & ChrW(1103): s3 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1939-01-25#, #2021-01-20#, 5, 2, 2)"
    s1 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1077) & ChrW(1077) & ChrW(1074): s2 = ChrW(1057) & ChrW(1090) & ChrW(1077) & ChrW(1087) & ChrW(1072) & ChrW(1085): s3 = ChrW(1043) & ChrW(1088) & ChrW(1080) & ChrW(1075) & ChrW(1086) & ChrW(1088) & ChrW(1100) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1941-11-30#, #2022-09-10#, 6, 1, 1)"
    s1 = ChrW(1055) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074): s2 = ChrW(1042) & ChrW(1072) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1090) & ChrW(1080) & ChrW(1085): s3 = ChrW(1048) & ChrW(1083) & ChrW(1100) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1944-05-12#, #2023-01-15#, 7, 2, 1)"
    s1 = ChrW(1058) & ChrW(1088) & ChrW(1086) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1042) & ChrW(1077) & ChrW(1088) & ChrW(1072): s3 = ChrW(1055) & ChrW(1072) & ChrW(1074) & ChrW(1083) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1937-11-22#, #2022-07-01#, 7, 3, 2)"
    s1 = ChrW(1041) & ChrW(1077) & ChrW(1083) & ChrW(1086) & ChrW(1074): s2 = ChrW(1043) & ChrW(1077) & ChrW(1085) & ChrW(1085) & ChrW(1072) & ChrW(1076) & ChrW(1080) & ChrW(1081): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1946-08-30#, #2023-03-10#, 8, 4, 1)"
    s1 = ChrW(1044) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1092) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1072): s2 = ChrW(1056) & ChrW(1080) & ChrW(1084) & ChrW(1084) & ChrW(1072): s3 = ChrW(1048) & ChrW(1083) & ChrW(1100) & ChrW(1080) & ChrW(1085) & ChrW(1080) & ChrW(1095) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1949-02-14#, #2022-11-20#, 8, 1, 2)"
    s1 = ChrW(1057) & ChrW(1091) & ChrW(1093) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074): s2 = ChrW(1055) & ChrW(1072) & ChrW(1074) & ChrW(1077) & ChrW(1083): s3 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1081) & ChrW(1083) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1940-07-08#, #2021-09-05#, 9, 2, 1)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1072): s2 = ChrW(1047) & ChrW(1080) & ChrW(1085) & ChrW(1072) & ChrW(1080) & ChrW(1076) & ChrW(1072): s3 = ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1935-12-01#, #2020-02-14#, 9, 5, 2)"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085): s2 = ChrW(1040) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1077) & ChrW(1081): s3 = ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1942-03-25#, #2023-05-01#, 10, 4, 1)"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085) & ChrW(1072): s2 = ChrW(1048) & ChrW(1088) & ChrW(1080) & ChrW(1085) & ChrW(1072): s3 = ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1947-10-17#, #2022-08-12#, 10, 1, 2)"
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1082) & ChrW(1080) & ChrW(1085): s2 = ChrW(1057) & ChrW(1090) & ChrW(1077) & ChrW(1087) & ChrW(1072) & ChrW(1085): s3 = ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1939-06-09#, #2021-12-01#, 10, 2, 1)"
    s1 = ChrW(1048) & ChrW(1083) & ChrW(1080) & ChrW(1085) & ChrW(1072): s2 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1080) & ChrW(1103): s3 = ChrW(1048) & ChrW(1083) & ChrW(1100) & ChrW(1080) & ChrW(1085) & ChrW(1080) & ChrW(1095) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('" & s1 & "', '" & s2 & "', '" & s3 & "', #1950-01-28#, #2023-07-20#, 3, 1, 2)"
    
    ' 4. Medicinskie procedury (tip 1-7, sotrudnik 1-10, zhilec 1-20)
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-15 09:00#, 1, 1)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-15 09:30#, 1, 2)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-16 10:00#, 1, 5)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (3, #2024-01-17 11:00#, 5, 1)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-18 09:00#, 3, 3)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (4, #2024-01-19 14:00#, 2, 5)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (5, #2024-01-20 10:30#, 1, 7)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-21 09:00#, 1, 8)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-22 10:00#, 1, 4)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-23 09:00#, 7, 10)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (6, #2024-01-24 11:00#, 9, 11)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-25 10:30#, 1, 12)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (3, #2024-01-26 14:00#, 5, 13)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-27 09:00#, 3, 14)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (7, #2024-01-28 08:00#, 1, 15)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (4, #2024-01-29 15:00#, 2, 16)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-30 09:00#, 1, 17)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-31 10:00#, 7, 18)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-02-01 09:00#, 1, 19)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (5, #2024-02-02 11:00#, 1, 20)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-02-03 09:30#, 3, 1)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (6, #2024-02-05 10:00#, 9, 5)"
    db.Execute "INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-02-10 09:00#, 1, 8)"
    
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-05#, 45000, 3, 1)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-05#, 45000, 3, 2)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-06#, 50000, 2, 3)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-07#, 45000, 4, 4)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-08#, 55000, 3, 5)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-10#, 45000, 1, 6)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-10#, 48000, 2, 7)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-12#, 45000, 3, 8)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-15#, 45000, 3, 9)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 1)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 2)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 3)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 48000, 2, 4)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 4, 5)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 52000, 3, 6)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 1, 7)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 46000, 2, 8)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 9)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 3, 10)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 50000, 3, 11)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 2, 12)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 47000, 4, 13)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 3, 14)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 55000, 3, 15)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 1, 16)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 3, 17)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 3, 18)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 2, 19)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-05#, 45000, 3, 20)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-01#, 45000, 3, 1)"
    db.Execute "INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-03-01#, 45000, 3, 2)"
    
    s1 = ChrW(1057) & ChrW(1084) & ChrW(1080) & ChrW(1088) & ChrW(1085) & ChrW(1086) & ChrW(1074) & " " & ChrW(1040) & ChrW(1085) & ChrW(1076) & ChrW(1088) & ChrW(1077) & ChrW(1081) & " " & ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1077) & ChrW(1074) & ChrW(1080) & ChrW(1095)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-14 14:00#, 1)"
    s1 = ChrW(1050) & ChrW(1091) & ChrW(1079) & ChrW(1085) & ChrW(1077) & ChrW(1094) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1045) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-15 11:00#, 2)"
    s1 = ChrW(1055) & ChrW(1086) & ChrW(1087) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1080) & ChrW(1103)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-16 16:00#, 3)"
    s1 = ChrW(1042) & ChrW(1072) & ChrW(1089) & ChrW(1080) & ChrW(1083) & ChrW(1100) & ChrW(1077) & ChrW(1074) & " " & ChrW(1048) & ChrW(1075) & ChrW(1086) & ChrW(1088) & ChrW(1100)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-17 10:00#, 4)"
    s1 = ChrW(1060) & ChrW(1105) & ChrW(1076) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1053) & ChrW(1072) & ChrW(1090) & ChrW(1072) & ChrW(1083) & ChrW(1100) & ChrW(1103)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-18 15:00#, 5)"
    s1 = ChrW(1052) & ChrW(1080) & ChrW(1093) & ChrW(1072) & ChrW(1081) & ChrW(1083) & ChrW(1086) & ChrW(1074) & " " & ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-20 12:00#, 6)"
    s1 = ChrW(1053) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1054) & ChrW(1083) & ChrW(1100) & ChrW(1075) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-21 14:30#, 7)"
    s1 = ChrW(1042) & ChrW(1086) & ChrW(1083) & ChrW(1082) & ChrW(1086) & ChrW(1074) & " " & ChrW(1057) & ChrW(1077) & ChrW(1088) & ChrW(1075) & ChrW(1077) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-22 11:00#, 8)"
    s1 = ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1077) & ChrW(1077) & ChrW(1074) & ChrW(1072) & " " & ChrW(1042) & ChrW(1077) & ChrW(1088) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-23 13:00#, 9)"
    s1 = ChrW(1057) & ChrW(1084) & ChrW(1080) & ChrW(1088) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1040) & ChrW(1085) & ChrW(1085) & ChrW(1072) & " (" & ChrW(1074) & ChrW(1085) & ChrW(1091) & ChrW(1095) & ChrW(1082) & ChrW(1072) & ")"
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 4, #2024-01-28 15:00#, 1)"
    s1 = ChrW(1055) & ChrW(1072) & ChrW(1085) & ChrW(1086) & ChrW(1074) & " " & ChrW(1044) & ChrW(1084) & ChrW(1080) & ChrW(1090) & ChrW(1088) & ChrW(1080) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-29 14:00#, 10)"
    s1 = ChrW(1058) & ChrW(1088) & ChrW(1086) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1074) & " " & ChrW(1053) & ChrW(1080) & ChrW(1082) & ChrW(1086) & ChrW(1083) & ChrW(1072) & ChrW(1081)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-01-30 11:00#, 11)"
    s1 = ChrW(1041) & ChrW(1077) & ChrW(1083) & ChrW(1086) & ChrW(1074) & " " & ChrW(1045) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-01-31 16:00#, 12)"
    s1 = ChrW(1044) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1092) & ChrW(1077) & ChrW(1077) & ChrW(1074) & " " & ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-02-01 10:00#, 13)"
    s1 = ChrW(1057) & ChrW(1091) & ChrW(1093) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & " " & ChrW(1048) & ChrW(1088) & ChrW(1080) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-02-02 15:00#, 14)"
    s1 = ChrW(1041) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1085) & ChrW(1086) & ChrW(1074) & " " & ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1080) & ChrW(1103)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-02-03 12:00#, 15)"
    s1 = ChrW(1050) & ChrW(1086) & ChrW(1084) & ChrW(1080) & ChrW(1085) & " " & ChrW(1058) & ChrW(1072) & ChrW(1090) & ChrW(1100) & ChrW(1103) & ChrW(1085) & ChrW(1072)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 2, #2024-02-05 14:00#, 16)"
    s1 = ChrW(1052) & ChrW(1072) & ChrW(1088) & ChrW(1082) & ChrW(1080) & ChrW(1085) & " " & ChrW(1042) & ChrW(1080) & ChrW(1082) & ChrW(1090) & ChrW(1086) & ChrW(1088)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 1, #2024-02-06 11:00#, 17)"
    s1 = ChrW(1048) & ChrW(1083) & ChrW(1080) & ChrW(1085) & ChrW(1072) & " " & ChrW(1050) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1083) & ChrW(1100)
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & s1 & "', 3, #2024-02-08 13:00#, 20)"
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & ChrW(1055) & ChrW(1077) & ChrW(1090) & ChrW(1088) & ChrW(1086) & ChrW(1074) & ChrW(1072) & " " & ChrW(1042) & ChrW(1077) & ChrW(1088) & ChrW(1072) & "', 2, #2024-02-10 10:00#, 3)"
    db.Execute "INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('" & ChrW(1057) & ChrW(1080) & ChrW(1076) & ChrW(1086) & ChrW(1088) & ChrW(1086) & ChrW(1074) & " " & ChrW(1040) & ChrW(1083) & ChrW(1077) & ChrW(1082) & ChrW(1089) & ChrW(1072) & ChrW(1085) & ChrW(1076) & ChrW(1088) & "', 1, #2024-02-12 15:00#, 6)"
    
    MsgBox ChrW(1044) & ChrW(1072) & ChrW(1085) & ChrW(1085) & ChrW(1099) & ChrW(1077) & " " & ChrW(1091) & ChrW(1089) & ChrW(1087) & ChrW(1077) & ChrW(1096) & ChrW(1085) & ChrW(1086) & " " & ChrW(1076) & ChrW(1086) & ChrW(1073) & ChrW(1072) & ChrW(1074) & ChrW(1083) & ChrW(1077) & ChrW(1085) & ChrW(1099) & "." & vbCrLf & ChrW(1053) & ChrW(1077) & ChrW(1079) & ChrW(1072) & ChrW(1073) & ChrW(1091) & ChrW(1076) & ChrW(1080) & ChrW(1090) & ChrW(1077) & " " & ChrW(1086) & ChrW(1073) & ChrW(1085) & ChrW(1086) & ChrW(1074) & ChrW(1080) & ChrW(1090) & ChrW(1100) & " " & ChrW(1090) & ChrW(1072) & ChrW(1073) & ChrW(1083) & ChrW(1080) & ChrW(1094) & ChrW(1099) & " (F5 ili zakroyte i otkroyte).", vbInformation
    Exit Sub
    
Err_Insert:
    MsgBox ChrW(1054) & ChrW(1096) & ChrW(1080) & ChrW(1073) & ChrW(1082) & ChrW(1072) & ": " & Err.Description & " (" & ChrW(1082) & ChrW(1086) & ChrW(1076) & " " & Err.Number & ")" & vbCrLf & ChrW(1041) & ChrW(1072) & ChrW(1079) & ChrW(1072) & ": " & db.Name, vbCritical
End Sub
