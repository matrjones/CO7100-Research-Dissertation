using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using ReptileAPI.Models;

namespace ReptileAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        // Default Constructor
        public ApplicationDbContext() : base() { }

        // Constructor
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        // Link db table to model
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Models.Environment>().ToTable("Environments");
            modelBuilder.Entity<Vivarium>().ToTable("Vivaria");
            modelBuilder.Entity<Parameter>().ToTable("Parameters");
            base.OnModelCreating(modelBuilder);
        }

        // Creating db sets
        public DbSet<Models.Environment> Environments { get; set; }
        public DbSet<Vivarium> Vivaria { get; set; }
        public DbSet<Parameter> Parameters { get; set; }

        // Implementing create date and modified date columns in db
        public override int SaveChanges()
        {
            // Implementation for data addition
            var added = ChangeTracker.Entries<IBaseEntity>().Where(E => E.State == EntityState.Added).ToList();
            foreach(var entry in added)
            {
                entry.Property(X => X.CreatedDate).CurrentValue = DateTime.Now;
                entry.Property(X => X.CreatedDate).IsModified = true;

                entry.Property(X => X.ModifiedDate).CurrentValue = DateTime.Now;
                entry.Property(X => X.ModifiedDate).IsModified = true;
            }

            // Implementation for data modification
            var modified = ChangeTracker.Entries<IBaseEntity>().Where(E => E.State == EntityState.Modified).ToList();
            foreach (var entry in modified)
            {
                entry.Property(X => X.CreatedDate).CurrentValue = entry.Property(X => X.CreatedDate).OriginalValue;
                entry.Property(X => X.CreatedDate).IsModified = false;

                entry.Property(X => X.ModifiedDate).CurrentValue = DateTime.Now;
                entry.Property(X => X.ModifiedDate).IsModified = true;
            }

            return base.SaveChanges();
        }
    }
}
