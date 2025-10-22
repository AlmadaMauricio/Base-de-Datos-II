use DBTutorias;

/* 1- Realizar un trigger que al registrar la postulación de un estudiante a una materia:
- Verifique que el Estudiante este activo.
- Verifique que no se repita el Rol para esa Materia y Estudiante.
- Registre la postulación del estudiante.*/

GO
CREATE TRIGGER TR_Postulacion_Estudiante_Materia
ON EstudiantesMaterias
AFTER INSERT
AS
BEGIN
    -- Verifica si el estudiante insertado está inactivo
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Estudiantes e ON i.IDEstudiante = e.IDEstudiante
        WHERE e.Activo = 0
    )
    BEGIN
        RAISERROR('El estudiante está inactivo y no puede postularse.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Verifica si ya existe el mismo rol para la misma materia y estudiante
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN EstudiantesMaterias em
            ON em.IDEstudiante = i.IDEstudiante
           AND em.IDMateria = i.IDMateria
           AND em.Rol = i.Rol
    )
    BEGIN
        RAISERROR('Ya existe una postulación con el mismo rol para esta materia.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    PRINT 'Postulación registrada exitosamente.';
END;
GO