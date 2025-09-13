use BDArchivos;

/*1 Todos los usuarios indicando Apellido, Nombre.*/
Select Nombre, Apellido From Usuarios;

/*2 Todos los usuarios indicando Apellido y Nombre con el formato: [Apellido], [Nombre] (ordenados por Apellido en forma descendente).*/
Select Nombre, Apellido From Usuarios
Order By Apellido desc;

/*3 Los usuarios cuyo IDTipoUsuario sea 5 (indicando Nombre, Apellido)*/

Select Nombre, Apellido From Usuarios
Where IDTipoUsuario = 5;

/*4 El último usuario del listado en orden alfabético (ordenado por Apellido y luego por Nombre). Indicar IDUsuario, Apellido y Nombre.*/
Select Top(1) IDUsuario, Apellido, Nombre From Usuarios
ORDER by Apellido Desc;

/*5 Los archivos cuyo año de creación haya sido 2021 (Indicar Nombre, Extensión y Fecha de creación).*/
Select Nombre, Extension, FechaCreacion From Archivos
Where YEAR(FechaCreacion) = 2021;

/*6 Todos los usuarios con el siguiente formato Apellido, Nombre en una nueva columna llamada ApellidoYNombre, en orden alfabético.*/
Select Apellido + Nombre As 'ApellidoYNombre' From Usuarios
ORDER BY ApellidoYNombre ASC;

/*7 Todos los archivos, indicando el semestre en el cual se produjo su fecha de creación. Indicar Nombre, Extensión, Fecha de Creación
y la frase “Primer Semestre” o “Segundo Semestre” según corresponda.*/
Select Nombre, Extension, FechaCreacion,
Case when MONTH(FechaCreacion) < = 6 then 'Primer Semestre'
when MONTH(FechaCreacion) > = 7 then 'Segundo Semestre'
End As 'Ejercicio 7'
From Archivos;

/*8 Ídem al punto anterior, pero ordenarlo por semestre y fecha de creación.*/
Select Nombre, Extension, FechaCreacion,
Case when MONTH(FechaCreacion) < = 6 then 'Primer Semestre'
when MONTH(FechaCreacion) > = 7 then 'Segundo Semestre'
End As Ejercicio7
From Archivos
ORDER BY Ejercicio7, FechaCreacion;

/*9 Todas las Extensiones de los archivos creados. NOTA: no se pueden repetir.*/
Select Distinct Extension From Archivos;

/*10 Todos los archivos que no estén eliminados. Indicar IDArchivo, IDUsuarioDueño, Fecha de Creación y Tamaño del archivo.
Ordenar los resultados por Fecha de Creación (del más reciente al más antiguo).*/
Select * From Archivos
Where Eliminado = 1
ORDER BY FechaCreacion asc;

/*11 Todos los archivos que estén eliminados cuyo Tamaño del archivo se encuentre entre 40960 y 204800 (ambos inclusive).
Indicar el valor de todas las columnas.*/
Select * From Archivos
Where (Tamaño > = 40960 and Tamaño < = 204800) And (Eliminado = 1);

/*12 Listar los meses del año en los que se crearon los archivos entre los años 2020 y 2022 (ambos inclusive).
NOTA: no indicar más de una vez el mismo mes.*/
Select Distinct datename(Month, FechaCreacion) AS Mes
From Archivos
Where YEAR(FechaCreacion) > = 2020 and YEAR(FechaCreacion) < = 2022;

/*13 Indicar los distintos ID de los Usuarios Dueños de archivos que nunca modificaron sus archivos y que no se encuentren eliminados.
NOTA: no se pueden repetir.*/
Select distinct IDUsuarioDueño
From Archivos
Where (Eliminado = 0) and FechaCreacion = FechaUltimaModificacion;

/*14 Listar todos los datos de los Archivos cuyos Dueños sean los usuarios con ID 1, 3, 5, 8, 9.
Los registros deben estar ordenados por IDUsuarioDueño y Tamaño de forma ascendente.*/
Select * from Archivos
Where idUsuarioDueño in(1, 3, 5, 8, 9)
Order By IDUsuarioDueño, Tamaño asc;


/*15 Listar todos los datos de los tres Archivos de más bajo Tamaño que no se encuentren Eliminados.*/
Select TOP(3) * from Archivos
Where Eliminado = 0
Order By Tamaño ASC;


/*16 Listar los Archivos que estén Eliminados y la Fecha de Ultima Modificación sea menor o igual al año 2021 o bien no estén Eliminados y la Fecha de Ultima Modificación sean mayor al año 2021. Indicar todas las columnas excepto IDUsuarioDueño y Fecha de Creación. Ordenar por IDArchivo.*/
Select IDArchivo, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaUltimaModificacion, Eliminado
From Archivos
Where (Eliminado = 1 and year(FechaUltimaModificacion) < = 2021) or
      (Eliminado = 0 and year(FechaUltimaModificacion) > = 2021)
Order By IDArchivo;


/*17 Listar los Archivos creados en el año 2023 indicando todas las columnas y además una llamada “DiaSemana” que devuelva a qué día de la semana (1-7) corresponde la fecha de creación del archivo. Ordenar los registros por la columna que contiene el día de la semana.
DESAFÍO: crear otra columna llamada DiaSemanaEnLetras que contenga el día de la semana, pero en letras (suponiendo que la semana comienza en 1-DOMINGO). Por ejemplo, si la fecha del Archivo es 20/08/2023, la columna DiaSemana debe contener 1 y la columna DiaSemanaEnLetras debe contener DOMINGO.*/
Select *,
Case when datepart(weekday, FechaCreacion) = 1 then 'Domingo'
     when datepart(weekday, FechaCreacion) = 2 then 'Lunes'
     when datepart(weekday, FechaCreacion) = 3 then 'Martes'
     when datepart(weekday, FechaCreacion) = 4 then 'Miercoles'
     when datepart(weekday, FechaCreacion) = 5 then 'Jueves'
     when datepart(weekday, FechaCreacion) = 6 then 'Viernes'
     when datepart(weekday, FechaCreacion) = 7 then 'Sabado'
	End AS DiaSemana
From Archivos
Where year(FechaCreacion) = 2023
Order By DiaSemana 


/*18 Listar los Archivos que no estén Eliminados y cuyo mes de creación coincida con el mes actual (sin importar el año). NOTA: obtener el mes actual mediante una función, no forzar el valor.*/
Select * from Archivos
Where (Eliminado = 0) and ((month(getdate())) = month(FechaCreacion))

/*20 Listar los Archivos que no hayan sido creados por los Usuarios con ID 1, 2, ,5, 9 y 10. Indicar IDUsuarioDueño, IDArchivo, fecha de creación y Tamaño. Ordenar por IDUsuarioDueño*/
Select IDUsuarioDueño, IDArchivo, FechaCreación, Tamaño
From Archivos
Where IDUsuarioDueño not in(1, 2, 5, 9, 10)
Order By IDUsuarioDueño;

/*21 Listar todos los datos de los Usuarios cuyos apellidos comienzan con J. Hacer la misma consulta para los Usuarios con apellido que comienza con J y el Nombre comienza con E. Ordenar los registros por IDUsuario.*/

Select * from Usuarios
Where Apellido Like 'J%'
Order By IDUsuario;

Select * from Usuarios
Where Apellido Like 'J%' and Nombre Like 'E%'
Order By IDUsuario;

/*22 Listar todos los datos de los Archivos que tengan el mayor Tamaño. En caso de empate se deben listar todos los Archivos con igual Tamaño.*/



















