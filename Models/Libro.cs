﻿using System.ComponentModel.DataAnnotations.Schema;

namespace BiblioAPI.Models
{
    public class LibroModel
    { 
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Autor { get; set; }
        public string Editorial { get; set; }
        public string ISBN { get; set; }
        public int Anio { get; set; }
        public int Existencias { get; set; }
        public string Categoria { get; set; }
        

        public string ImagenURL { get; set; }
    }
}
