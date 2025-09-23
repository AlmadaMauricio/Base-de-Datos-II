use BDArchivos;
/*1 La cantidad de archivos con extensión zip.*/
Select Count(Archivos.Extension) As 'Archivos Zip'
From Archivos
Where Extension = 'zip';

/*2 La cantidad de archivos que fueron modificados y, por lo tanto, su fecha de última modificación no es la misma que la fecha de creación.*/
Select Count(*) As 'ArchivosModificados'
From Archivos As A
Where A.FechaUltimaModificacion != A.FechaCreacion;

/*3 La fecha de creación más antigua de los archivos con extensión pdf.*/
Select Min(A.FechaCreacion) As 'FechaAntigua'
From Archivos A
Where A.Extension = 'pdf';

/*4 La cantidad de extensiones distintas cuyos archivos tienen en su nombre o en su descripción la palabra 'Informe' o 'Documento'.*/
Select Count(Distinct A.Extension) As 'Archivos'
From Archivos A
Where A.Descripcion Like '%Informe%' or
A.Descripcion Like '%Documento%';

/*5 El promedio de tamaño (expresado en Megabytes) de los archivos con extensión 'doc', 'docx', 'xls', 'xlsx'.*/
Select Round(Avg(A.Tamaño / 1048576.0), 2)
From Archivos A
Where A.Extension IN('doc', 'docx', 'xls', 'xlsx');

/*6 La cantidad de archivos que le fueron compartidos al usuario con apellido 'Clarck'*/
Select Count(*) As 'CantidadArchivos'
From ArchivosCompartidos AC
Inner Join Usuarios U On AC.IDUsuario = U.IDUsuario
Where U.Apellido = 'Clarck';

/*7 La cantidad de tipos de usuario que tienen asociado usuarios que registren, como dueños, archivos con extensión pdf.*/
Select count(Distinct TU.IDTipoUsuario) As 'TiposUsuarios'
From TiposUsuario TU
Inner Join Usuarios U On TU.IDTipoUsuario = U.IDTipoUsuario
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
Where A.Extension = 'pdf';


/*8 El tamaño máximo expresado en Megabytes de los archivos que hayan sido creados en el año 2024.*/
Select Round(Max(A.Tamaño / 1048576.0), 2) As 'MaxTamañoMB'
From Archivos A
Where Year(A.FechaCreacion) = 2024;


/*9 El nombre del tipo de usuario y la cantidad de usuarios distintos de dicho tipo que registran, como dueños, archivos con extensión pdf.*/
Select TU.TipoUsuario, count(Distinct U.IDUsuario) As 'Usuarios'
From TiposUsuario TU
Inner Join Usuarios U On TU.IDTipoUsuario = U.IDTipoUsuario
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
Where A.Extension = 'pdf'
Group by TU.TipoUsuario;

/*10 El nombre y apellido de los usuarios dueños y la suma total del tamaño de los archivos que tengan compartidos con otros usuarios.
Mostrar ordenado de mayor sumatoria de tamaño a menor.*/
Select U.Nombre, U.Apellido, sum(A.Tamaño) As 'SumatoriaTamaño'
From Usuarios U
Inner Join Archivos A On U.IDUsuario = A.IDUsuarioDueño
Inner Join ArchivosCompartidos Ac On A.IDArchivo = AC.IDArchivo
GROUP BY U.Nombre, U.Apellido
Order By SumatoriaTamaño Desc;

/*11 El nombre del tipo de archivo y el promedio de tamaño de los archivos que corresponden a dicho tipo de archivo.*/
Select TA.TipoArchivo, AVG(A.Tamaño) As 'PromedioTamaño'
From TiposArchivos TA
Inner Join Archivos A On TA.IDTipoArchivo = A.IDTipoArchivo
GROUP BY TA.TipoArchivo;









