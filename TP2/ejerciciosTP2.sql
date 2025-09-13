use Archivos;

select * from Archivos;

Alter table ArchivosCompartidos
Alter column FechaCompartido Date not null;

Alter table Archivos
Alter column FechaUltimaModificacion date not null;


/*2- Actualizar descripción de archivo eliminado:
Cambiar la descripción del archivo llamado 'Documento Eliminado' a 'Archivo eliminado por el usuario'.*/
Update Archivos Set Descripcion = 'Archivo eliminado por el usuario'
Where Nombre = 'Documento Eliminado';

/*3- Marcar como eliminados archivos viejos:
Establecer Eliminado = 1 en los archivos cuya FechaCreacion sea anterior al '2021-01-01' y que aún no estén eliminados. */


select * from Archivos
Where Eliminado = 1 and FechaCreacion < '2021-01-01'

Update Archivos set Eliminado = 1
Where FechaCreacion < '2021-01-01' and Eliminado = 0;

Delete from Archivos;
DBCC CHECKIDENT ('Archivos', RESEED, 0);


/*4- Eliminar un archivo ZIP del usuario 1:  Eliminar un archivo ZIP del usuario con ID 1 (podés elegir cualquiera de ellos). */
Select * from Archivos
Where Extension = 'Zip' and IDUsuarioDueño = 1;

Delete from ArchivosCompartidos
Where IDArchivo = 3;

Delete From Archivos
Where IDArchivo = 3 and Extension = 'Zip' and IDUsuarioDueño = 1;


/*5- Asignar permiso de lectura: Insertar un nuevo permiso de Lectura para el usuario con ID = 10 sobre el archivo con ID = 1.  */

insert into ArchivosCompartidos(IDUsuario, IDArchivo, IDPermiso, FechaCompartido)
Values(10, 1, 1, GETDATE());

/*6- Eliminar archivos antiguos eliminados: Borrar archivos con Eliminado = 1 y FechaUltimaModificacion anterior al '2022-01-01'.*/
Delete from ArchivosCompartidos
Where IDArchivo in (
    select IDArchivo
    from Archivos
    Where Eliminado = 1
    and FechaUltimaModificacion < '2022-01-01'
)

/*Paso 1: eliminar primero las referencias en ArchivosCompartidos
Porque si no, el DELETE en Archivos va a fallar por la restricción de clave foránea:*/
Delete from Archivos
Where Eliminado = 1 and FechaUltimaModificacion < '2022-01-01';

Select * from Archivos
Where Eliminado = 1 and FechaUltimaModificacion < '2022-01-01';

/*De esta forma te asegurás de borrar primero las dependencias y luego los archivos, cumpliendo con la restricción de FK.*/


/*7. Corregir extensión de imagen: Cambiar la extensión 'jpg' por 'jpeg' en archivos cuyo tipo de archivo sea 'Imagen JPEG'. */
Select * from Archivos
Where Extension = 'jpeg';

Update Archivos set Extension = 'JPEG'
Where Extension = 'jpg';

/*8. Insertar archivo y compartirlo:
Insertar un archivo nuevo en la tabla Archivos y luego usar tres INSERT INTO para compartirlo con distintos usuarios
(uno con Lectura, otro con Escritura y otro con Administrador).*/ 
insert into Archivos(IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado)
Values(4, 'Asesoria juridica', 'pdf', 'ejercicio 8', 1, 51000, '1996-10-04', '2025-08-31', 0);

Select * from Usuarios;

DBCC CHECKIDENT ('Archivos');
DBCC CHECKIDENT ('Archivos', RESEED, 72);

insert into ArchivosCompartidos(IDArchivo, IDUsuario, IDPermiso, FechaCompartido)
Values(73, 3, 1, '2025-08-31');

insert into ArchivosCompartidos(IDArchivo, IDUsuario, IDPermiso, FechaCompartido)
Values(73, 5, 3, '2025-08-31');

insert into ArchivosCompartidos(IDArchivo, IDUsuario, IDPermiso, FechaCompartido)
Values(73, 8, 4, '2025-08-31');

select * from ArchivosCompartidos
Where IDArchivo = 73;

/*9. Asignar permiso administrador a un usuario premium:
Insertar un permiso de Administrador sobre el archivo con ID = 5 para un usuario con ID = 4.*/
Select * from ArchivosCompartidos
Where IDArchivo = 5 and IDUsuario = 9;

Select * from Permisos;

Select * from Usuarios
Where IDTipoUsuario = 4;

insert into ArchivosCompartidos(IDArchivo, IDUsuario, IDPermiso, FechaCompartido)
Values(5, 9, 4, '2025-09-01');

/*10. Reemplazo de archivo eliminado:
Borrar un archivo PPTX eliminado, y luego insertar uno nuevo con el mismo nombre seguido de '_v2', misma descripción y fecha actual.*/

select * from Archivos
Where Extension = 'PPTX';

Delete from Archivos
Where IDArchivo = 36;

Insert into Archivos(IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion)
VALUES(8, 'Version antigua_v2', 'pptx', 'Version nueva de la presentacion', 8, 204800, '2025-01-09', '2025-01-09');



