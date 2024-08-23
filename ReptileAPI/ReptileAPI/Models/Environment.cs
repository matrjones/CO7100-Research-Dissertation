using ReptileAPI.Data;

namespace ReptileAPI.Models
{
    public class Environment : BaseEntity
    {
        public double Temperature { get; set; }
        public bool Light { get; set; }
    }
}
