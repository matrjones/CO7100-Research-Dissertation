using Microsoft.Identity.Client;

namespace ReptileAPI.Data
{
    public interface IDbInitializer
    {
        void Initialize();
    }

    public class DbInitializer : IDbInitializer
    {
        private readonly IConfiguration _configuration;
        private readonly ApplicationDbContext _context;

        public DbInitializer(IConfiguration configuration, ApplicationDbContext context)
        { 
            _configuration = configuration;
            _context = context;
        }

        public void Initialize() { }
    }
}
