using BiblioAPI.Models;
using BiblioAPI.Services;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace BiblioAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PrestamoController : Controller
    {
        private readonly PrestamoService _prestamoService;

        public PrestamoController(PrestamoService prestamoService)
        {
            _prestamoService = prestamoService;
        }

        [HttpGet]
        public async Task<ActionResult<List<Prestamo>>> ObtenerPrestamos()
        {
            var prestamos = await _prestamoService.ObtenerPrestamosAsync();
            return Ok(prestamos);
        }

        [HttpPost]  
        public async Task<IActionResult> RegistrarPrestamo([FromBody] Prestamo prestamo)
        {
            if (prestamo.FechaPrestamo == default)
            {
                return BadRequest("La fecha del préstamo no puede estar vacía.");
            }

            if (prestamo.FechaDevolucionEsperada < DateTime.Today)
            {
                return BadRequest("La fecha de devolución esperada debe ser válida.");
            }

            try
            {
                await _prestamoService.RegistrarPrestamoAsync(prestamo);
                return Ok(new { mensaje = "Préstamo registrado correctamente" });
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { error = ex.Message  }); 
            }
            catch (Exception ex)
            {
                // Error inesperado
                return StatusCode(500, new { error = "Error interno al registrar el préstamo.", detalle = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<ActionResult> ActualizarPrestamo(int id, [FromBody] Prestamo prestamo)
        {
            var actualizado = await _prestamoService.ActualizarPrestamoAsync(id, prestamo);
            if (!actualizado)
            {
                return NotFound();
            }
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> EliminarPrestamo(int id)
        {
            var eliminado = await _prestamoService.EliminarPrestamoAsync(id);
            if (!eliminado)
            {
                return NotFound();
            }
            return NoContent();
        }
        [HttpGet("pendientes")]
        public async Task<ActionResult<List<Prestamo>>> ObtenerPrestamosPendientes(string correo)
        {
            var prestamos = await _prestamoService.ObtenerPrestamosPendientesPorCorreoAsync(correo);
            return Ok(prestamos);
        }

        [HttpPut("devolver/{id}")]
        public async Task<IActionResult> MarcarComoDevuelto(int id)
        {
            var exito = await _prestamoService.MarcarComoDevueltoAsync(id);
            if (!exito)
            {
                return BadRequest(new { error = "No se pudo marcar el préstamo como devuelto. Verifique si ya fue devuelto o si el ID es inválido." });
            }

            return Ok(new { mensaje = "Libro devuelto correctamente." });
        }

    }
}
