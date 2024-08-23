using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ReptileAPI.Data;
using ReptileAPI.Models;

namespace ReptileAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VivariumController : ControllerBase
    {
        // Instance variables
        private readonly ILogger<VivariumController> _logger;
        private readonly ApplicationDbContext _context;

        // Constructor
        public VivariumController(ILogger<VivariumController> logger, ApplicationDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        // Create method
        [HttpPost]
        [Route("Create")]
        public IActionResult Create(Vivarium vivarium)
        {
            try
            {
                _context.Vivaria.Add(vivarium);
                _context.SaveChanges();
                return Ok(vivarium);
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
                var vivarium = _context.Vivaria.Where(E => E.Id == ID).First();
                return Ok(vivarium);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        // Get by object method
        [HttpPost]
        [Route("Update")]
        public IActionResult Update(Vivarium viv)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _context.Vivaria.Update(viv);
                    _context.SaveChanges();
                    return Ok(viv);
                }
                else
                {
                    throw new Exception("Unable to update vivarium.");
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
                var vivarium = _context.Vivaria.First(E => E.Id == id);
                _context.Vivaria.Remove(vivarium);
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
        public IActionResult Delete(Vivarium viv)
        {
            try
            {
                _context.Vivaria.Remove(viv);
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
