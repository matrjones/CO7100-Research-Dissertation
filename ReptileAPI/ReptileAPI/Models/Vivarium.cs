using ReptileAPI.Data;

namespace ReptileAPI.Models
{
    public class Vivarium : BaseEntity
    {
        public string Name { get; set; }
        public virtual Environment Environment { get; set; }
    }
}
