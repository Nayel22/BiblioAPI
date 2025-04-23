using BiblioAPI.Models;
using BiblioAPI.Services;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace BiblioAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : Controller
    {
        private readonly UsuarioService _usuarioService;

        public UsuarioController(UsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }

        [HttpGet]
        public async Task<ActionResult<List<Usuario>>> ObtenerUsuarios()
        {
            var usuarios = await _usuarioService.ObtenerUsuariosAsync();
            return Ok(usuarios);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Usuario>> ObtenerUsuarioPorId(int id)
        {
            var usuario = await _usuarioService.ObtenerUsuarioPorIdAsync(id);
            if (usuario == null)
            {
                return NotFound();
            }
            return Ok(usuario);
        }

        [HttpPost("registrar")]
        public async Task<ActionResult> RegistrarUsuario([FromBody] Usuario usuario)
        {
            try
            {
                if (string.IsNullOrEmpty(usuario.Correo) || string.IsNullOrEmpty(usuario.Clave))
                    return BadRequest("Correo y clave son requeridos");

                await _usuarioService.CrearUsuarioAsync(usuario);
                return Ok(new { Id = usuario.Id, Mensaje = "Registro exitoso" });
            }
            catch (SqlException ex) when (ex.Number == 2627)
            {
                return Conflict("El correo ya está registrado");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno: {ex.Message}");
            }
        }
        
        

        [HttpPut("{id}")]
        public async Task<ActionResult> ActualizarUsuario(int id, [FromBody] Usuario usuario)
        {
            var actualizado = await _usuarioService.ActualizarUsuarioAsync(id, usuario);
            if (!actualizado)
            {
                return NotFound();
            }
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> EliminarUsuario(int id)
        {
            var eliminado = await _usuarioService.EliminarUsuarioAsync(id);
            if (!eliminado)
            {
                return NotFound();
            }
            return NoContent();
        }

        [HttpPost("validar")]
        public async Task<ActionResult<Usuario>> ValidarUsuario([FromQuery] string correo, [FromQuery] string clave)
        {
            var usuario = await _usuarioService.ValidarUsuarioAsync(correo, clave);
            if (usuario == null)
            {
                return Unauthorized(); // 401 si no se encuentra el usuario
            }
            return Ok(usuario); // Retorna el usuario si la validación es exitosa
        }
          
    }
}
