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









