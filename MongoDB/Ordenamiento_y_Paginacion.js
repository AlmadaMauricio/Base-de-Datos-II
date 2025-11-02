// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use('angeles_films');

// PARTE 1 - CREAR BASE DE DATOS -> angeles_films
// PARTE 2 - INSERTAR DOCUMENTO EN COLLECTION -> peliculas
// PARTE 3 - ORDENAMIENTO
// 1- Traer todas las películas ordenadas por año de estreno, de más nueva a más vieja.
//db.peliculas.find({}).sort({anio: 1})
// 2- Listar las películas ordenadas por duración, de menor a mayor.
//db.peliculas.find({}).sort({duracion: 1})
// 3- Mostrar todas las películas ordenadas alfabéticamente por título.
//db.peliculas.find({}).sort({titulo: 1})

/*###############################################################################################*/

// PARTE 4 - PAGINACIÓN
// 1- Traer las primeras 3 películas de la colección.
//db.peliculas.find({}).limit(3)
// 2- Saltar las primeras 5 y mostrar las siguientes 2.
//db.peliculas.find({}).skip(5).limit(2)
// 3- Mostrar la segunda página de resultados si cada página tiene 4 películas.
//db.peliculas.find({}).skip(4).limit(4)

/*###############################################################################################*/

// PARTE 5 - ORDENAMIENTO Y PAGINACIÓN
// 1- Mostrar las 3 películas más largas, ordenadas de mayor a menor duración.
//db.peliculas.find({}).sort({duracion: -1}).limit(3)
// 2- Listar 5 películas ordenadas por rating descendente, pero solo mostrar las 3 primeras.
//db.peliculas.find({}).sort({rating: -1}).limit(3)
// 3- Mostrar las primeras 2 películas de Animación ordenadas por año de estreno ascendente.
//db.peliculas.find({genero: "Animación"}).sort({anio: 1}).limit(2)
// 4- Traer películas ordenadas por título, pero mostrar solo desde la cuarta en adelante (salteando 3).
db.peliculas.find({}).sort({titulo: 1}).skip(3)