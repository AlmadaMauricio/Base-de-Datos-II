use BDArchivos;

/*1 Los nombres y extensiones y tamaño en Megabytes de los archivos que pesen más que el promedio de archivos.*/
Select A.Nombre, A.Extension, (A.Tamaño / 1048576.0) As 'TamañoMB'
From Archivos A
Where A.Tamaño > (Select AVG(Tamaño) From Archivos);

/*2 Los usuarios indicando apellido y nombre que no sean dueños de ningún archivo con extensión 'zip'.*/
Select U.Apellido, U.Nombre 
From Usuarios U 
Left Join Archivos A On U.IDUsuario = A.IDUsuarioDueño and A.Extension = 'zip'
Where A.IDArchivo is null;

/*3 Los usuarios indicando IDUsuario, apellido, nombre y tipo de usuario que no hayan creado ni modificado ningún archivo en el año actual.*/
SELECT 
    U.IDUsuario, 
    U.Apellido, 
    U.Nombre, 
    TU.TipoUsuario
FROM Usuarios U
INNER JOIN TiposUsuario TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE NOT EXISTS (
    SELECT 1
    FROM Archivos A
    WHERE A.IDUsuarioDueño = U.IDUsuario
      AND (
          YEAR(A.FechaCreacion) = 2025
          OR YEAR(A.FechaUltimaModificacion) = 2025
      )
);

/*4 Los tipos de usuario que no registren usuario con archivos eliminados.*/
Select TU.TipoUsuario
From TiposUsuario TU
Inner Join Usuarios U On TU.IDTipoUsuario = U.IDTipoUsuario
Where not exists (select IDUsuarioDueño From Archivos A Where A.IDUsuarioDueño = U.IDUsuario And Eliminado = 1);

/*5 Los tipos de archivos que no se hayan compartido con el permiso de 'Lectura'*/
SELECT TU.TipoArchivo
FROM TiposArchivos TU
WHERE NOT EXISTS (
SELECT 1
FROM Archivos A
INNER JOIN ArchivosCompartidos AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos P ON AC.IDPermiso = P.IDPermiso
WHERE P.Nombre = 'Lectura'
AND A.IDTipoArchivo = TU.IDTipoArchivo
);

/*6 Los nombres y extensiones de los archivos que tengan un tamaño mayor al del archivo con extensión 'xls' más grande.*/
Select A.Nombre, A.Extension
From Archivos A
Where A.Tamaño > (Select Max(Ar.Tamaño) From Archivos Ar Where Ar.Extension = 'xls');

/*7 Los nombres y extensiones de los archivos que tengan un tamaño mayor al del archivo con extensión 'zip' más pequeño.*/
Select A.Nombre, A.Extension
From Archivos A
Where A.Tamaño > (Select Min(Ar.Tamaño) From Archivos Ar Where Ar.Extension = 'zip');

/*8 Por cada tipo de archivo indicar el tipo y la cantidad de archivos eliminados y la cantidad de archivos no eliminados.*/
Select TA.TipoArchivo,
sum(Case when A.Eliminado = 1 then 1 else 0 end) As 'Eliminado',
sum(Case when A.Eliminado = 0 then 1 else 0 end) As 'No Eliminado'
From TiposArchivos TA
Inner Join Archivos A On TA.IDTipoArchivo = A.IDTipoArchivo
GROUP BY Ta.TipoArchivo;

/*9 Por cada usuario indicar el IDUsuario, el apellido, el nombre,
la cantidad de archivos pequeños (menos de 20MB) y la cantidad de archivos grandes (20MBs o más)*/
Select U.IDUsuario, U.Apellido, U.Nombre,
Sum(Case when A.Tamaño < 20971520 Then 1 else 0 end) As Menor20MB,
Sum(Case when A.Tamaño >= 20971520 then 1 else 0 end) As Mayor20MB
From Usuarios U
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
GROUP BY U.IDUsuario, U.Apellido, U.Nombre;

/*10 Por cada usuario indicar el IDUsuario, el apellido, el nombre y la cantidad de archivos creados en el año 2022,
la cantidad en el año 2023 y la cantidad creados en el 2024.*/
Select U.IDUsuario, U.Apellido, U.Nombre,
Sum(Case When YEAR(A.FechaCreacion) = 2022 Then 1 else 0 end) As Creado2022,
Sum(Case When YEAR(A.FechaCreacion) = 2023 Then 1 else 0 end) As Creado2023,
Sum(Case When YEAR(A.FechaCreacion) = 2024 Then 1 else 0 end) As Creado2024
From Usuarios U
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
GROUP BY U.IDUsuario, U.Apellido, U.Nombre;

/*11 Los archivos que fueron compartidos con permiso de 'Comentario' pero no con permiso de 'Lectura'*/
SELECT DISTINCT A.*
FROM Archivos A
INNER JOIN ArchivosCompartidos AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos P ON AC.IDPermiso = P.IDPermiso
WHERE P.Nombre = 'Comentario'
AND NOT EXISTS (SELECT 1
FROM ArchivosCompartidos AC2
INNER JOIN Permisos P2 ON AC2.IDPermiso = P2.IDPermiso
WHERE AC2.IDArchivo = A.IDArchivo
AND P2.Nombre = 'Lectura');

/*12 Los tipos de archivos que registran más archivos eliminados que no eliminados.*/




