using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ReptileAPI.Data;
using ReptileAPI.Models;
using System.Reflection.Metadata.Ecma335;

namespace ReptileAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EnvironmentController : ControllerBase
    {
        // Instance variables
        private readonly ILogger<EnvironmentController> _logger;
        private readonly ApplicationDbContext _context;

        // Constructor
        public EnvironmentController(ILogger<EnvironmentController> logger, ApplicationDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        // Create method
        [HttpPost]
        [Route("Create")]
        public IActionResult Create(Models.Environment environment)
        {
            try
            {
                _context.Environments.Add(environment);
                _context.SaveChanges();
                return Ok(environment);
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
                var environment = _context.Environments.Where(E => E.Id == ID).First();
                return Ok(environment);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Get by object method
        [HttpPost]
        [Route("Update")]
        public IActionResult Update(Models.Environment env)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _context.Environments.Update(env);
                    _context.SaveChanges();
                    return Ok(env);
                }
                else
                {
                    throw new Exception("Unable to update environment.");
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
                var environment = _context.Environments.First(E => E.Id == id);
                _context.Environments.Remove(environment);
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
        public IActionResult Delete(Models.Environment env)
        {
            try
            {
                _context.Environments.Remove(env);
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
