// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use('angeles_films');

// PARTE 1 - CREACION DE BASE DE DATOS LLAMADA -> angeles_film
// PARTE 2 - INSERCION DE DATOS EN COLLECTION -> peliculas
// PARTE 3 - CONSULTAS
//1- Buscar las películas con un rating mayor a 8.5.
db.peliculas.find({rating: {$gt: 8.5}});
//2- Traer las películas que duren entre 100 y 150 minutos.
db.peliculas.find({duracion: {$gte: 100}, duracion: {$lte: 150}});
//3- Buscar las películas cuyo género sea Animación o Ciencia Ficción.
db.peliculas.find({
  $or: [
    { genero: "Animación" },
    { genero: "Ciencia Ficción" }
  ]
})
//4- Mostrar las películas que no sean aptas para todo público.
db.peliculas.find({aptaTodoPublico: false});
//5- Listar las películas dirigidas por Nolan o Bong Joon-ho.
db.peliculas.find({
	$or: [
		{director: "Christopher Nolan"},
		{director: "Bong Joon-ho"}
	]
})
//6- Buscar películas que no sean del género Animación ni Acción.
db.peliculas.find({
  $nor: [
    { genero: "Animación" },
    { genero: "Acción" }
  ]
})
//7- Mostrar las películas que no tengan campo "director".
db.peliculas.find({ director: { $exists: false } });
//8- Buscar películas cuyo título contenga la palabra "dark", sin importar mayúsculas.
db.peliculas.find({
	titulo: {$regex: "dark", $options: "i"}
})
//9- Listar las películas de más de 150 minutos que no fueron dirigidas por Nolan.
db.peliculas.find({
	duracion: {$gt: 150},
	director: {$ne: "Christopher Nolan"}
})
//10-Traer las películas que duren más de 90 minutos y sean de Animación.
db.peliculas.find({
	duracion: {$gt: 90},
	genero: "Animación"
})

/*#######################################################################################################*/

// PARTE 4 - ACTUALIZACIONES
// 1- Cambiar la duración de la película “Tenet” a 155 minutos.
db.peliculas.updateOne(
	{titulo: "Tenet"},
    {$set: {duracion: 155} }
)
// 2- Aumentar el rating de todas las películas de Animación a 8.9.
db.peliculas.updateMany(
    {genero: "Animación"},
    {$set: {rating: 8.9}}
)
// 3- Establecer que todas las películas de más de 160 minutos no sean aptas para todo público.
db.peliculas.updateMany(
    {duracion: {$gt: 160}},
    {$set: {aptaTodoPublico: false}}
)
// 4- Agregar un campo “clasificación: ATP” a todas las películas aptas para todo público.
db.peliculas.updateMany(
    {aptaTodoPublico: true},
    {$set: {Clasificacion: "ATP"}}
)
// 5- Modificar el director a “Desconocido” en todas las películas que duren menos de 90 minutos.
db.peliculas.updateMany(
    {duracion: {$lt: 90}},
    {$set: {director: "Desconocido"}}
)

/*#######################################################################################################*/

// PARTE 5 - ELIMINACIONES
// 1- Eliminar la película llamada “Up”.
db.peliculas.deleteOne({titulo: "Up"})
// 2- Borrar todas las películas que tengan un rating menor a 8.0.
db.peliculas.deleteMany({rating: {$lt: 8.0}})
// 3- Eliminar todas las películas estrenadas en el año 2019.
db.peliculas.deleteMany({anio: 2019});
// 4- Borrar las películas de Animación que duren menos de 90 minutos.
db.peliculas.deleteMany({
  $and: [
    { genero: "Animación" },
    { duracion: { $lt: 90 } }
  ]
})
// 5- Eliminar las películas no aptas para todo público que no hayan sido dirigidas por Nolan.
db.peliculas.deleteMany({
  $and: [
    { aptaTodoPublico: false },
    { director: { $ne: "Christopher Nolan" } }
  ]
})
