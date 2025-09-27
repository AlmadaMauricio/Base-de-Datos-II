use BDArchivos;

/*1 Los nombres y extensiones y tamaño en Megabytes de los archivos que pesen más que el promedio de archivos.*/
Select A.Nombre, A.Extension, (A.Tamaño / 1048576.0) As 'TamañoMB'
From Archivos A
Where A.Tamaño > (Select AVG(Tamaño) From Archivos);

/*2 Los usuarios indicando apellido y nombre que no sean dueños de ningún archivo con extensión 'zip'.*/
Select U.Apellido, U.Nombre 
From Usuarios U 
Left Join Archivos A On U.IDUsuario = A.IDUsuarioDueño 
 



