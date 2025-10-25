use DBTutorias;

/* 1- Realizar un trigger que al registrar la postulación de un estudiante a una materia:
- Verifique que el Estudiante este activo.
- Verifique que no se repita el Rol para esa Materia y Estudiante.
- Registre la postulación del estudiante.*/
Go;
/*
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
GO*/

/*Realizar un trigger que al agregar una tutoría:
- Verifique que el Estudiante Tutor y el Estudiante Alumno están activos.
	- Verifique que El Tutor y Alumno no sean los mismos.
-  Verifique tanto el tutor como el alumno se hayan postulado en esa materia con los respectivos
 roles.
	- Verifique que el Estudiante Alumno tenga suficientes créditos (No menor a 5 créditos negativos)
- Descuente los créditos al Estudiante Alumno.
- Registre la tutoría.*/

CREATE TRIGGER TR_Agregar_Tutoria
ON Tutorias
INSTEAD OF INSERT
AS
BEGIN
    ---------------------------------------------------------
    -- 1) Verificar que el tutor y el alumno no sean la misma persona
    ---------------------------------------------------------
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.IDEstudianteTutor = i.IDEstudianteAlumno
    )
    BEGIN
        PRINT('Error: El tutor y el alumno no pueden ser la misma persona.');
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    ---------------------------------------------------------
    -- 2) Verificar que ambos estudiantes estén activos
    ---------------------------------------------------------
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Estudiantes t ON t.IDEstudiante = i.IDEstudianteTutor
        LEFT JOIN Estudiantes a ON a.IDEstudiante = i.IDEstudianteAlumno
        WHERE t.Activo = 0 OR a.Activo = 0
    )
    BEGIN
        PRINT('Error: El tutor o el alumno no están activos.');
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    ---------------------------------------------------------
    -- 3) Verificar que el tutor y el alumno estén postulados
    --    en la materia con los roles correctos
    ---------------------------------------------------------
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 
            FROM EstudiantesMaterias em
            WHERE em.IDEstudiante = i.IDEstudianteTutor
              AND em.IDMateria = i.IDMateria
              AND em.Rol = 'TUTOR'
        )
        OR NOT EXISTS (
            SELECT 1 
            FROM EstudiantesMaterias em
            WHERE em.IDEstudiante = i.IDEstudianteAlumno
              AND em.IDMateria = i.IDMateria
              AND em.Rol = 'ALUMNO'
        )
    )
    BEGIN
        PRINT('Error: El tutor o el alumno no están postulados con el rol correcto en la materia.');
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    ---------------------------------------------------------
    -- 4) Verificar que el alumno tenga créditos suficientes
    ---------------------------------------------------------
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Estudiantes a ON a.IDEstudiante = i.IDEstudianteAlumno
        WHERE (a.SaldoCredito - 1) < -5
    )
    BEGIN
        PRINT('Error: El alumno no tiene créditos suficientes (límite -5).');
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    ---------------------------------------------------------
    -- 5) Descontar crédito al alumno
    ---------------------------------------------------------
    UPDATE e
    SET e.SaldoCredito = e.SaldoCredito - 1
    FROM Estudiantes e
    INNER JOIN inserted i ON i.IDEstudianteAlumno = e.IDEstudiante;

    ---------------------------------------------------------
    -- 6) Registrar el movimiento en el historial de créditos
    ---------------------------------------------------------
    INSERT INTO HistorialCreditos (IDEstudiante, Tipo, Cantidad, Descripcion)
    SELECT 
        i.IDEstudianteAlumno,
        'DEBITO', 1, 'Descuento por registro de tutoría'
    FROM inserted i;

    ---------------------------------------------------------
    -- 7) Registrar la tutoría
    ---------------------------------------------------------
    INSERT INTO Tutorias (IDEstudianteTutor, IDEstudianteAlumno, IDMateria, Fecha, Duracion, ConfirmaTutor, ConfirmaAlumno, Estado)
    SELECT IDEstudianteTutor, IDEstudianteAlumno, IDMateria, Fecha, Duracion, ConfirmaTutor, ConfirmaAlumno, Estado
    FROM inserted;

    PRINT('Tutoría registrada correctamente.');
END;
GO

