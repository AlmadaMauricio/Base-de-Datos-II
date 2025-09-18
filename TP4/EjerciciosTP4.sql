use BDArchivos;

/*1 Por cada usuario listar el nombre, apellido y el nombre del tipo de usuario.*/
Select U.Nombre, U.Apellido, TU.TipoUsuario
From Usuarios As U
Inner Join TiposUsuario As TU On U.IDTipoUsuario = TU.IDTipoUsuario;

/*2 Listar el ID, nombre, apellido y tipo de usuario de aquellos usuarios que sean del tipo 'Suscripción Free' o 'Suscripción Básica'*/
Select U.IDUsuario, U.Nombre, U.Apellido, TU.TipoUsuario
From Usuarios As U
Inner Join TiposUsuario As TU On U.IDTipoUsuario = TU.IDTipoUsuario
Where TU.TipoUsuario In ('Suscripción Free', 'Suscripción Básica');

/*3 Listar los nombres de archivos, extensión, tamaño expresado en Megabytes y el nombre del tipo de archivo.
NOTA: En la tabla Archivos el tamaño está expresado en Bytes.*/
Select A.Nombre, A.Extension, Round(A.Tamaño / 1048576.0, 2) As Tamaño, TA.TipoArchivo
From Archivos As A
Inner Join TiposArchivos As TA On A.IDTipoArchivo = TA.IDTipoArchivo;

/*4 Listar los nombres de archivos junto a la extensión con el siguiente formato 'NombreArchivo.extension'. Por ejemplo, 'Actividad.pdf'.
Sólo listar aquellos cuyo tipo de archivo contenga los términos 'ZIP', 'Word', 'Excel', 'Javascript' o 'GIF'*/
Select A.Nombre + '.' + A.Extension As NuevoFormato
From Archivos As A
Inner Join TiposArchivos As TA On A.IDTipoArchivo = TA.IDTipoArchivo
Where TA.TipoArchivo LIKE '%ZIP%'
or TA.TipoArchivo LIKE '%Word%'
or TA.TipoArchivo LIKE '%Excel%'
or TA.TipoArchivo LIKE '%Javascript%'
or TA.TipoArchivo LIKE '%GIF%'

/*5 Listar los nombres de archivos, su extensión, el tamaño en megabytes y
la fecha de creación de aquellos archivos que le pertenezcan al usuario dueño con nombre 'Michael' y apellido 'Williams'.*/

/*/7 Listar nombres de archivos, extensión, tamaño en bytes, fecha de creación y de modificación,
apellido y nombre del usuario dueño de aquellos archivos cuya descripción contengan el término 'empresa' o 'presupuesto'*/
Select A.Nombre, A.Extension, A.Tamaño, A.FechaCreacion, FechaUltimaModificacion, U.Apellido, U.Nombre
From Archivos A
Inner Join Usuarios U On A.IdUsuarioDueño = U.IdUsuario
Where A.Descripcion Like '%Empresa%' 
or A.Descripcion Like '%Presupuesto%';


/*/8 Listar las extensiones sin repetir de los archivos cuyos usuarios dueños tengan tipo de usuario 'Suscripción Plus', 'Suscripción Premium' o 'Suscripción Empresarial'*/
Select Distinct A.Extension
From Archivos A
Inner Join Usuarios U On A.IdUsuarioDueño = U.IdUsuario
Inner Join TiposUsuario TU On U.IdTipoUsuario = TU.idTipoUsuario
Where TU.TipoUsuario In ('Suscripción Plus', 'Suscripción Premium', 'Suscripción Empresarial')

/*9 Listar los apellidos y nombres de los usuarios dueños y el tamaño del archivo de los tres archivos con extensión 'zip' más pesados.
Puede ocurrir que el mismo usuario aparezca varias veces en el listado.*/

Select Top(3) U.Nombre, U.Apellido, A.Tamaño
From Usuarios U
Inner Join Archivos A on A.IdUsuarioDueño = U.IdUsuario
Where A.Extension = 'ZIP'
Order By Tamaño Desc;

/*10 Por cada archivo listar el nombre del archivo, la extensión, el tamaño en bytes, el nombre del tipo de archivo y el tamaño calculado en su mayor expresión y la unidad calculada. Siendo Gigabytes si al menos pesa un gigabyte, Megabytes si al menos pesa un megabyte, Kilobyte si al menos pesa un kilobyte o en su defecto expresado en bytes.
Por ejemplo, si el archivo imagen.jpg pesa 40960 bytes entonces debe figurar 40 en la columna Tamaño Calculado y 'Kilobytes' en la columna unidad.*/

SELECT 
    A.NombreArchivo, A.Extension, A.Tamaño AS TamañoBytes, T.NombreTipoArchivo,
    CASE 
        WHEN A.Tamaño >= 1073741824 THEN A.Tamaño / 1073741824
        WHEN A.Tamaño >= 1048576   THEN A.Tamaño / 1048576
        WHEN A.Tamaño >= 1024      THEN A.Tamaño / 1024
        ELSE A.Tamaño
    END AS TamañoCalculado,
    CASE 
        WHEN A.Tamaño >= 1073741824 THEN 'Gigabytes'
        WHEN A.Tamaño >= 1048576   THEN 'Megabytes'
        WHEN A.Tamaño >= 1024      THEN 'Kilobytes'
        ELSE 'Bytes'
    END AS Unidad
FROM Archivos A
INNER JOIN TiposArchivo T ON A.IdTipoArchivo = T.IdTipoArchivo;

/*11 Listar los nombres de archivo y extensión de los archivos que han sido compartidos.*/
Select A.Nombre, A.Extension
From Archivos A
Inner Join ArchivosCompartidos AC On A.idArchivo = AC.IdArchivo;

/*12 Listar los nombres de archivo y extensión de los archivos que han sido compartidos a usuarios con apellido 'Clarck' o 'Jones'*/
Select A.Nombre, A.Extension
From Archivos A
Inner Join ArchivosCompartidos AC On A.IDArchivo = AC.IDArchivo
Inner Join Usuarios U On U.IDUsuario = AC.IDUsuario
Where U.Apellido = 'Clarck' Or U.Apellido = 'Jones';

/*13 Listar los nombres de archivo, extensión, apellidos y nombres de los usuarios a quienes se le hayan compartido archivos con permiso de 'Escritura'*/
Select A.Nombre, A.Extension, U.Apellido, U.Nombre
From Archivos A
Inner Join ArchivosCompartidos AC on AC.IDArchivo = A.IDArchivo
Inner Join Usuarios U on AC.IDUsuario = U.IDUsuario
Inner Join Permisos P on AC.IDPermiso = P.IDPermiso
Where P.Nombre = 'Escritura'

/*14 Listar los nombres de archivos y extensión de los archivos que no han sido compartidos.*/
Select A.Nombre, A.Extension
From Archivos A
Left Join ArchivosCompartidos AC On A.IDArchivo = AC.IDArchivo
Where AC.IDArchivo IS NULL;

/*15 Listar los apellidos y nombres de los usuarios dueños que tienen archivos eliminados.*/
Select U.Apellido, U.Nombre
From Usuarios U
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
Where A.Eliminado = 1;

/*16 Listar los nombres de los tipos de suscripciones, sin repetir, que tienen archivos que pesan al menos 120 Megabytes.*/
Select Distinct TU.TipoUsuario
From TiposUsuario TU
Inner Join Usuarios U On TU.IDTipoUsuario = U.IDTipoUsuario
Inner Join Archivos A On U.IDUsuario = A.IDUsuario
Where A.Tamaño >= 125829120;

/*17 Listar los apellidos y nombres de los usuarios dueños, nombre del archivo, extensión, fecha de creación, fecha de modificación
y la cantidad de días transcurridos desde la última modificación.
Sólo incluir a los archivos que se hayan modificado (fecha de modificación distinta a la fecha de creación).*/
Select U.Nombre As NombreUsuario, U.Apellido, A.Nombre As NombreArchivo, A.Extension, A.FechaCreacion, A.FechaUltimaModificacion,
Datediff(day, A.FechaUltimaModificacion, GETDATE()) As DiasTrasncurridos
From Usuarios U
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
where A.FechaCreacion != A.FechaUltimaModificacion;

/*18 Listar nombres de archivos, extensión, tamaño,
apellido y nombre del usuario dueño del archivo,
apellido y nombre del usuario que tiene el archivo compartido
y el nombre de permiso otorgado.*/
Select A.Nombre As NombreArchivo, A.Extension, A.Tamaño, --Archivos
UsDue.Apellido As ApellidoDueño, UsDue.Nombre As NombreDueño, --Usuarios Dueños
UsCom.Apellido As ApellidoCompartido, UsCom.Nombre As NombreCompartido, -- Usuarios Compartidos
P.Nombre --Permiso
From Archivos A
Inner Join ArchivosCompartidos Ac On A.IDArchivo = Ac.IDArchivo
Inner Join Usuarios UsDue On UsDue.IDUsuario = A.IDUsuarioDueño
Inner Join Usuarios UsCom On UsCom.IDUsuario = Ac.IDUsuario
Inner Join Permisos P On P.IDPermiso = Ac.IDPermiso

/*19 Listar nombres de archivos, extensión, tamaño,
apellido y nombre del usuario dueño del archivo,
apellido y nombre del usuario que tiene el archivo compartido
y el nombre de permiso otorgado.
Sólo listar aquellos registros cuyos tipos de usuarios coincidan tanto para el dueño como para el usuario al que le comparten el archivo.*/
Select A.Nombre, A.Extension, A.Tamaño, --Archivos
UsDue.Apellido As ApellidoDueño, UsDue.Nombre As NombreDueño, --Usuarios Dueños (Usuarios)
UsCom.Apellido As ApellidoCompartido, UsCom.Nombre As NombreCompartido, --Usuarios Compartidos (ArchivosCompartidos)
P.Nombre --Permiso
From Archivos A
Inner Join ArchivosCompartidos Ac On Ac.IDArchivo = A.IDArchivo
Inner Join Usuarios UsDue On UsDue.IDUsuario = A.IDUsuarioDueño
Inner Join Usuarios UsCom On UsCom.IDUsuario = Ac.IDUsuario
Inner Join Permisos P On P.IDPermiso = Ac.IDPermiso
Inner Join TiposUsuario TUD On TUD.IDTipoUsuario = UsDue.IDTipoUsuario
Inner Join TiposUsuario TUC On TUC.IDTipoUsuario = UsCom.IDTipoUsuario
Where (TUD.IDTipoUsuario = TUC.IDTipoUsuario);








