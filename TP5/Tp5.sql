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








