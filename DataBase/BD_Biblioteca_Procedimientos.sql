

-- InsertarLibro (incluye ahora ImagenURL)
CREATE PROCEDURE InsertarLibro
    @Titulo     NVARCHAR(100),
    @Autor      NVARCHAR(100),
    @Editorial  NVARCHAR(100),
    @ISBN       NVARCHAR(20),
    @Anio       INT,
    @Categoria  NVARCHAR(50),
    @Existencias INT,
    @ImagenURL  NVARCHAR(255)
AS
BEGIN
INSERT INTO Libros (Titulo, Autor, Editorial, ISBN, Anio, Categoria, Existencias, ImagenURL)
VALUES (@Titulo, @Autor, @Editorial, @ISBN, @Anio, @Categoria, @Existencias, @ImagenURL);
END;
GO

-- ObtenerLibros (sin cambios)
CREATE PROCEDURE ObtenerLibros
    AS
BEGIN
SELECT * FROM Libros;
END;
GO

-- ActualizarLibro (incluye ahora ImagenURL)
CREATE PROCEDURE ActualizarLibro
    @Id          INT,
    @Titulo      NVARCHAR(100),
    @Autor       NVARCHAR(100),
    @Editorial   NVARCHAR(100),
    @ISBN        NVARCHAR(20),
    @Anio        INT,
    @Categoria   NVARCHAR(50),
    @Existencias INT,
    @ImagenURL   NVARCHAR(255)
AS
BEGIN
UPDATE Libros
SET Titulo     = @Titulo,
    Autor      = @Autor,
    Editorial  = @Editorial,
    ISBN       = @ISBN,
    Anio       = @Anio,
    Categoria  = @Categoria,
    Existencias = @Existencias,
    ImagenURL  = @ImagenURL
WHERE Id = @Id;
END;
GO

-- EliminarLibro (sin cambios)
CREATE PROCEDURE EliminarLibro
    @Id INT
AS
BEGIN
DELETE FROM Libros WHERE Id = @Id;
END;
GO

--------------------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS PARA USUARIOS (sin cambios)
--------------------------------------------------------------------------------

CREATE PROCEDURE InsertarUsuario
    @Nombre     NVARCHAR(50),
    @Apellido   NVARCHAR(50),
    @Correo     NVARCHAR(100),
    @Telefono   NVARCHAR(20),
    @TipoUsuario NVARCHAR(20),
    @Clave      NVARCHAR(100)
AS
BEGIN
INSERT INTO Usuarios (Nombre, Apellido, Correo, Telefono, TipoUsuario, Clave)
VALUES (@Nombre, @Apellido, @Correo, @Telefono, @TipoUsuario, @Clave);
END;
GO

CREATE PROCEDURE ObtenerUsuarios
    AS
BEGIN
SELECT * FROM Usuarios;
END;
GO

CREATE PROCEDURE ActualizarUsuario
    @Id         INT,
    @Nombre     NVARCHAR(50),
    @Apellido   NVARCHAR(50),
    @Correo     NVARCHAR(100),
    @Telefono   NVARCHAR(20),
    @TipoUsuario NVARCHAR(20),
    @Clave      NVARCHAR(100)
AS
BEGIN
UPDATE Usuarios
SET Nombre     = @Nombre,
    Apellido   = @Apellido,
    Correo     = @Correo,
    Telefono   = @Telefono,
    TipoUsuario = @TipoUsuario,
    Clave      = @Clave
WHERE Id = @Id;
END;
GO

CREATE PROCEDURE EliminarUsuario
    @Id INT
AS
BEGIN
DELETE FROM Usuarios WHERE Id = @Id;
END;
GO

CREATE PROCEDURE ValidarUsuario
    @Correo NVARCHAR(100),
    @Clave  NVARCHAR(100)
AS
BEGIN
SELECT * FROM Usuarios
WHERE Correo = @Correo AND Clave = @Clave;
END;
GO

--------------------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS PARA PRÉSTAMOS (sin cambios)
--------------------------------------------------------------------------------

CREATE PROCEDURE RegistrarPrestamo
    @IdUsuario                INT,
    @IdLibro                  INT,
    @FechaDevolucionEsperada  DATETIME,
    @Estado                   NVARCHAR(20) = 'Pendiente'
AS
BEGIN
INSERT INTO Prestamos (IdUsuario, IdLibro, FechaDevolucionEsperada, Estado)
VALUES (@IdUsuario, @IdLibro, @FechaDevolucionEsperada, @Estado);

-- Actualizar existencias del libro
UPDATE Libros
SET Existencias = Existencias - 1
WHERE Id = @IdLibro;
END;
GO

CREATE PROCEDURE ObtenerPrestamos
    AS
BEGIN
SELECT * FROM Prestamos;
END;
GO

CREATE PROCEDURE ActualizarPrestamo
    @Id                   INT,
    @FechaDevolucionReal  DATETIME,
    @Estado               NVARCHAR(20)
AS
BEGIN
UPDATE Prestamos
SET FechaDevolucionReal = @FechaDevolucionReal,
    Estado              = @Estado
WHERE Id = @Id;
END;
GO

CREATE PROCEDURE EliminarPrestamo
    @Id INT
AS
BEGIN
DELETE FROM Prestamos WHERE Id = @Id;
END;
GO

