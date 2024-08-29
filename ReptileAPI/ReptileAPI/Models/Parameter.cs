using ReptileAPI.Data;

namespace ReptileAPI.Models
{
    public class Parameter : BaseEntity
    {
        public TimeOnly LightOn { get; set; }
        public TimeOnly LightOff { get; set; }
        public int DayTemp { get; set; }
        public int NightTemp { get; set; }
    }
}
