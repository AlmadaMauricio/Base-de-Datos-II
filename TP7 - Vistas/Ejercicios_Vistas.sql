use DBTutorias;
Go;
/*1- Crear una vista que devuelva el listado de todos los estudiantes que estén activos en el sistema
mostrando su legajo, nombre, apellido, email y saldo de créditos actual.*/

/*Create view VW_Estudiantes_Activos AS 
Select E.Legajo, E.Nombre, E.Apellido, E.Email, E.SaldoCredito
From Estudiantes E 
Where E.Activo = 1;

Select * From VW_Estudiantes_Activos;*/


/*2- Crear una vista que devuelva todas las materias registradas en el sistema,
mostrando su nombre, código de materia, carrera a la que pertenece y nivel.*/

/*Create view VW_Materias_Registradas As
Select M.Nombre, M.CodigoMateria, M.Carrera, M.Nivel
From Materias M;

Select * From VW_Materias_Registradas;*/

/*3- Crear una vista que devuelva el listado de postulaciones de estudiantes a materias,
mostrando el nombre completo del estudiante, el nombre de la materia y el rol (Tutor o Alumno) en el que se postuló.*/
/*Create view VW_Listado_Postulaciones 
As 
Select E.Apellido + ', ' + E.Nombre AS NombreCompleto,
M.Nombre, ExM.Rol
From Estudiantes E
Inner Join EstudiantesMaterias ExM On E.IDEstudiante = ExM.IDEstudiante
Inner Join Materias M On ExM.IDMateria = M.IDMateria;*/

/*4- Crear una vista que devuelva las tutorías que fueron confirmadas tanto por el tutor como por el alumno,
mostrando la fecha, duración, nombre de la materia, nombre completo del tutor y nombre completo del alumno.*/
/*Create View VW_Tutorias_Confirmadas
As
Select T.Fecha, T.Duracion, M.Nombre, ET.Apellido + ', ' + ET.Nombre AS NombreCompletoTutor,
EA.Apellido + ', ' + EA.Nombre AS NombreCompletoAlumno
From Tutorias T
Inner Join Estudiantes ET On T.IDEstudianteTutor = ET.IDEstudiante
Inner Join Estudiantes EA On T.IDEstudianteAlumno = EA.IDEstudiante
Inner Join Materias M On T.IDMateria = M.IDMateria
Where ConfirmaTutor = 1 And ConfirmaAlumno = 1;*/

/*5- Crear una vista que devuelva el historial de movimientos de créditos de todos los estudiantes,
mostrando el nombre completo del estudiante, la fecha del movimiento, el tipo de movimiento (Gana o Usa),
la cantidad de créditos y la descripción del movimiento.*/
Create View VW_Creditos_Estudiantes
As
Select E.Apellido + ', ' + E.Nombre AS NombreCompleto,
HC.Fecha, HC.Tipo As TipoMovimiento, HC.Cantidad, HC.Descripcion
From HistorialCreditos HC
Inner Join Estudiantes E On HC.IDEstudiante = E.IDEstudiante;


