use DBTutorias;

/* 1- Realizar un trigger que al registrar la postulación de un estudiante a una materia:
- Verifique que el Estudiante este activo.
- Verifique que no se repita el Rol para esa Materia y Estudiante.
- Registre la postulación del estudiante.*/

Create Trigger TR_Postulacion_Estudiante_Materia
On EstudiantesMaterias
After Insert
As
Begin
    IF EXISTS(
        Select 1 
        From Inserted I
        Inner Join Estudiantes E On I.IDEstudiante = E.IDEstudiante
        Where E.Activo = 0
    )
    Begin
        RAISERROR('Existe.', 16, 1);
        ROLLBACK TRANSACTION;
        Return;
    End;

    Print 'Postulacion exitosa.';



End;

