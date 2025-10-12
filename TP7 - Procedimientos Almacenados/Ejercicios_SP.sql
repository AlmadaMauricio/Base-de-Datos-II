USE DBTutorias;
GO

/* Realizar un procedimiento almacenado llamado sp_Agregar_Estudiante que permita registrar un estudiante en el sistema.
El procedimiento debe recibir como parámetro Legajo, Nombre, Apellido y Email.*/
/*Create Procedure sp_Agregar_Estudiante
    @Legajo varchar(10),
    @Nombre varchar(100),
    @Apellido varchar(100),
    @Email varchar(150)
As
Begin
    Begin Try
        -- Validamos que no exista el estudiante
        If Exists (Select 1 From Estudiantes Where Legajo = @Legajo)
        Begin
            Raiserror('El legajo de estudiante ya existe.', 16, 1);
            Return;
        End;
        -- Insertamos nuevo Estudiante.
        Insert into Estudiantes(Legajo, Nombre, Apellido, Email, Activo)
        Values(@Legajo, @Nombre, @Apellido, @Email, 1);
        Print 'Estudiante insertado correctamente.';
    End Try
    Begin Catch
        Print 'Error al insertar estudiante: ' + Error_Message();
    End Catch;
End;

Select * From Estudiantes;
EXEC sp_Agregar_Estudiante '111', 'Mauricio', 'Almada', 'mauri@estudiante.utn';*/



/* 2 Realizar un procedimiento almacenado llamado sp_Agregar_Materia que permita registrar una materia en el sistema.
El procedimiento debe recibir como parámetro el Nombre, el Nivel, Carrera y CodigoMateria.*/
/*Create Procedure sp_Agregar_Materia
    @Nombre Varchar(100),
    @Nivel Tinyint,
    @Carrera Varchar(100),
    @CodigoMateria Varchar(4)
As
Begin
    Begin Try 
        --Validamos si existe la materia a insertar
        If Exists (Select 1 From Materias Where CodigoMateria = @CodigoMateria)
        Begin
            Raiserror('El codigo de materia ya existe', 16, 1);
            Return;
        End;

        --Insertamos una materia.
        Insert into Materias(Nombre, Nivel, Carrera, CodigoMateria)
        Values (@Nombre, @Nivel, @Carrera, @CodigoMateria);
        Print 'Materia agregada correctamente.';
    End Try
    Begin Catch
        Print 'Error al insertar una materia: ' + Error_Message();
    End Catch;
End;

Select * from Materias;
Exec sp_Agregar_Materia 'Programacion 1', 1, 'Tecnicatura universitaria en programacion', 1010;*/

/*Realizar un procedimiento almacenado llamado sp_Agregar_EstudianteMateria
que permita registrar el postulamiento de un estudiante como tutor o alumno a una materia en el sistema.
El procedimiento debe recibir como parámetro el IDEstudiante, el IDMateria y Rol (Tutor o Alumno).*/

Create Procedure sp_Agregar_EstudianteMateria
    @IDEstudiante int,
    @IDMateria int,
    @rol varchar(10)
As
Begin
    Begin Try
        -- Validamos si existe Estudiante postulado.
        If Exists (Select 1 From EstudiantesMaterias Where IDEstudiante = @IDEstudiante and IDMateria = @IDMateria and rol = @rol)
        Begin
            Raiserror ('El estudiante ya se encuentra postulado', 16, 1);
            Return;
        End;

        --Insertamos una materia.
        Insert into EstudiantesMaterias(IDEstudiante, IDMateria, Rol)
        Values(@IDEstudiante, @IDMateria, @rol);
        Print 'Estudiante postulado correctamente.';
    End Try 
    Begin Catch
        Print 'Error al postular un estudiante: ' + Error_Message();
    End Catch
End;

Exec sp_Agregar_EstudianteMateria '1', '1', 'Alumno'