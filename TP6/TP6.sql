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





