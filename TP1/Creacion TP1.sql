CREATE DATABASE BDArchivos
Collate Latin1_General_CI_AI
GO
USE BDArchivos;
GO
CREATE TABLE TiposUsuario (
    IDTipoUsuario INT PRIMARY KEY IDENTITY(1,1),
    TipoUsuario NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Usuarios (
    IDUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    IDTipoUsuario INT NOT NULL,
    FOREIGN KEY (IDTipoUsuario) REFERENCES TiposUsuario(IDTipoUsuario)
)
GO

CREATE TABLE TiposArchivos (
    IDTipoArchivo INT PRIMARY KEY IDENTITY(1,1),
    TipoArchivo NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Archivos (
    IDArchivo INT PRIMARY KEY IDENTITY(1,1),
    IDUsuarioDueño INT NOT NULL,
    Nombre NVARCHAR(255) NOT NULL,
    Extension NVARCHAR(10) NOT NULL,
    Descripcion NVARCHAR(500) NULL,
    IDTipoArchivo INT NOT NULL,
    Tamaño BIGINT NOT NULL, -- Expresado en Bytes
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    FechaUltimaModificacion DATETIME NOT NULL DEFAULT GETDATE(),
    Eliminado BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (IDUsuarioDueño) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDTipoArchivo) REFERENCES TiposArchivos(IDTipoArchivo)
)
GO

CREATE TABLE Permisos (
    IDPermiso INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE ArchivosCompartidos (
    IDArchivo INT NOT NULL,
    IDUsuario INT NOT NULL,
    IDPermiso INT NOT NULL,
    FechaCompartido DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDArchivo, IDUsuario),
    FOREIGN KEY (IDArchivo) REFERENCES Archivos(IDArchivo),
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDPermiso) REFERENCES Permisos(IDPermiso)
);

/*A partir de este esquema, deberán realizar las siguientes tareas utilizando comandos DDL.

Realizar un script en lenguaje TSQL que genere:
La base de datos que se proporciona con el DER.
La creación de tablas.
La definición de claves primarias y foráneas.
La aplicación de restricciones de integridad y la modificación de la estructura de la base de datos.
Tener en cuenta que:

Archivos
El IDArchivo debe ser autonumérico que comienza en 1 e incrementa de a 1.
El IDUsuarioDueño debe ser obligatorio y existir en la tabla Usuarios.
El Nombre, Extension y Descripcion deben ser obligatorios.
El IDTipoArchivo debe ser obligatorio y existir en la tabla TiposArchivos.
El Tamaño debe ser obligatorio.
La FechaCreacion y FechaUltimaModificacion deben ser obligatorias.
El campo Eliminado debe ser obligatorio.

TiposArchivos
El IDTipoArchivo debe ser autonumérico que comienza en 1 e incrementa de a 1.
El TipoArchivo debe ser obligatorio.

Usuarios
El IDUsuario debe ser autonumérico que comienza en 1 e incrementa de a 1.
El Nombre y Apellido deben ser obligatorios.
El IDTipoUsuario debe ser obligatorio y existir en la tabla TiposUsuario.

TiposUsuario
El IDTipoUsuario debe ser autonumérico que comienza en 1 e incrementa de a 1.
El TipoUsuario debe ser obligatorio.

Permisos
El IDPermiso debe ser autonumérico que comienza en 1 e incrementa de a 1.
El Nombre debe ser obligatorio.

ArchivosCompartidos
El IDArchivo debe ser obligatorio y existir en la tabla Archivos.
El IDUsuario debe ser obligatorio y existir en la tabla Usuarios.
El IDPermiso debe ser obligatorio y existir en la tabla Permisos.*/
