using Microsoft.AspNetCore.Mvc;
using ReptileAPI.Data;
using ReptileAPI.Models;

namespace ReptileAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ParameterController : ControllerBase
    {
        // Instance variables
        private readonly ILogger<ParameterController> _logger;
        private readonly ApplicationDbContext _context;

        // Constructor
        public ParameterController(ILogger<ParameterController> logger, ApplicationDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        // Create method
        [HttpPost]
        [Route("Create")]
        public IActionResult Create(Parameter parameter)
        {
            try
            {
                _context.Parameters.Add(parameter);
                _context.SaveChanges();
                return Ok(parameter);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Get by ID method
        [HttpGet]
        [Route("GetByID")]
        public IActionResult GetByID(Guid ID)
        {
            try
            {
                var parameter = _context.Parameters.Where(E => E.Id == ID).First();
                return Ok(parameter);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Get by object method
        [HttpPost]
        [Route("Update")]
        public IActionResult Update(Parameter parameter)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _context.Parameters.Update(parameter);
                    _context.SaveChanges();
                    return Ok(parameter);
                }
                else
                {
                    throw new Exception("Unable to update parameter.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Delete by ID method
        [HttpDelete]
        [Route("DeleteByID")]
        public IActionResult DeleteById(Guid id)
        {
            try
            {
                var parameter = _context.Parameters.First(P => P.Id == id);
                _context.Parameters.Remove(parameter);
                _context.SaveChanges();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Delete method
        [HttpDelete]
        [Route("Delete")]
        public IActionResult Delete(Parameter parameter)
        {
            try
            {
                _context.Parameters.Remove(parameter);
                _context.SaveChanges();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }
    }
}
