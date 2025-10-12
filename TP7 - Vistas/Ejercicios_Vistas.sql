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



