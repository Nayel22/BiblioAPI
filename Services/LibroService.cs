namespace BiblioAPI.Services
{
    public class LibroService
    {

        private readonly string _connectionString;

        public LibroService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("MiConexion");
        }

    }
}
