-- Crear la base de datos
CREATE DATABASE BibliotecaDB;
GO

-- Usar la base de datos creada
USE BibliotecaDB;
GO

-- Crear la tabla de Libros
CREATE TABLE Libros (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(100) NOT NULL,
    Autor NVARCHAR(100) NOT NULL,
    Editorial NVARCHAR(100) NOT NULL,
    ISBN NVARCHAR(20) NOT NULL,
    Anio INT NOT NULL,
    Categoria NVARCHAR(50) NOT NULL,
    Existencias INT NOT NULL
);

-- Crear la tabla de Usuarios  
CREATE TABLE Usuarios (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Correo NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20) NULL,
    TipoUsuario NVARCHAR(20) NOT NULL,
    Clave NVARCHAR(100) NOT NULL
);

-- Crear la tabla de Préstamos
CREATE TABLE Prestamos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT NOT NULL,
    IdLibro INT NOT NULL,
    FechaPrestamo DATETIME NOT NULL,
    FechaDevolucionEsperada DATETIME NOT NULL,
    FechaDevolucionReal DATETIME NULL,
    Estado NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Prestamos_Usuarios FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id),
    CONSTRAINT FK_Prestamos_Libros FOREIGN KEY (IdLibro) REFERENCES Libros(Id)
);

-- Insertar datos de ejemplo en Libros
INSERT INTO Libros (Titulo, Autor, Editorial, ISBN, Anio, Categoria, Existencias)
VALUES 
('Cien años de soledad', 'Gabriel García Márquez', 'Editorial Sudamericana', '978-84-376-0494-7', 1967, 'Novela', 10),
('1984', 'George Orwell', 'Secker & Warburg', '978-0-452-28423-4', 1949, 'Ficción distópica', 15),
('El principito', 'Antoine de Saint-Exupéry', 'Reynal & Hitchcock', '978-3-518-22329-7', 1943, 'Literatura infantil', 20);

-- Insertar datos de ejemplo en Usuarios (con Clave)
INSERT INTO Usuarios (Nombre, Apellido, Correo, Telefono, TipoUsuario, Clave)
VALUES 
('Karla', 'Brenes', 'karla.brenes@gmail.com', '8312-4567', 'Administrador', 'karla123'),
('Adrián', 'Cascante', 'adrian.cascante@gmail.com', '7201-8899', 'Cliente', 'adrian456'),
('Kayrel', 'Cascante', 'kayrel.cascante@gmail.com', '8654-2233', 'Cliente', 'kayrel789');
