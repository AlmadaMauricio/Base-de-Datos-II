// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use('angeles_films');

// Create a new document in the collection.

// PARTE 1 - CREAR BASE DE DATOS -> anegeles_films
// PARTE 2 - CREAR COLLECTIONS -> peliculas, directores, premios. INSERTAR DOCUMENTOS.
// PARTE 3 - UNIONES
//Traer todas las películas con los datos completos del director
db.peliculas.aggregate([
    {
        $lookup: {
          from: "directores",
          localField: "director._id",
          foreignField: "_id",
          as: "PeliculasDirector"
        }
    }
])

//db.peliculas.find()