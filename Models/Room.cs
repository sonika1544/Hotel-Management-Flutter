using System.ComponentModel.DataAnnotations;

namespace hotel_management.Models
{
    public class Room
    {
        public int Id { get; set; }

        [Required]
        public string Number { get; set; }

        [Required]
        public string Type { get; set; }

        [Required]
        public decimal Price { get; set; }

        public bool IsAvailable { get; set; }

        public string Description { get; set; }

        public List<string> Amenities { get; set; }

        public ICollection<Booking> Bookings { get; set; }
    }
}