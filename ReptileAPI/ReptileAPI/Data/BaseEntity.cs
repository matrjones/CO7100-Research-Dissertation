using System.ComponentModel.DataAnnotations;

namespace ReptileAPI.Data
{
    public interface IBaseEntity
    {
        DateTime CreatedDate { get; }
        DateTime ModifiedDate { get; set; }
    }

    public class BaseEntity : IBaseEntity
    {
        [Key]
        public Guid Id { get; set; }
        public DateTime CreatedDate { get; private set; }
        public DateTime ModifiedDate { get; set; }
    }
}
