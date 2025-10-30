// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.

use("academia");

/*
Parte 3 – Búsquedas
3.1 Traer todos los cursos X
3.2 Traer todos los profesores X
3.3 Traer los profesores que son de FRGP X
3.4 Traer todos los estudiantes de la provincia “Buenos Aires” X
*/
db.cursos.find();
db.docentes.find();
db.docentes.find({Sede: "FRGP"});
db.estudiantes.find();

//--------------------------------------------------------------------//

/*
Parte 4 – Actualizaciones
4.1 Actualizar el curso “JavaScript Avanzado” a 40 horas X
4.2 Actualizar el docente A (a través del _id) cambiando Tipo a Profesor, experiencia en 1 y legajo 4444 X
4.3 Cambiar la dirección de Juan a “Mendoza 456, Buenos  X
*/

db.cursos.updateMany
(
    {"Nombre del curso": "JavaScript Avanzado"},
    {$set: {"Duracion": "40 horas"}}
    )
    
   db.docentes.updateOne
   (
    { _id: ObjectId("68fe96b7bc9e9103aab428ad") },
    { $set: { Tipo: "Ayudante 2025", "Experiencia": 1, "Legajo": 4444}}
    )

db.estudiantes.updateOne
(
    { Nombre: "Juan" },
    { $set: { Direccion: { Calle: "Mendonza", Numero: 456, Provincia: "Buenos Aires" } } }
    )
   
   //--------------------------------------------------------------------//
   
   /*
   Parte 5 – Eliminaciones
   5.1 Eliminar el curso con nombre “JavaScript desde cero”. X
   5.2 Eliminar a todos los docentes que sean del tipo “Ayudante 2022”.
   */
  db.cursos.deleteOne
  (
      { "Nombre del curso": "JavaScript desde cero" }
  )

  
  