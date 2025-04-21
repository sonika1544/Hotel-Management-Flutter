using System.ComponentModel.DataAnnotations;

namespace hotel_management.Models
{
    public class Booking
    {
        public int Id { get; set; }

        public int RoomId { get; set; }
        public Room Room { get; set; }

        [Required]
        public string GuestName { get; set; }

        [Required]
        public DateTime CheckIn { get; set; }

        [Required]
        public DateTime CheckOut { get; set; }

        public decimal TotalPrice { get; set; }

        public string Status { get; set; }
    }
}