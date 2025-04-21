class Room {
  final String id;
  final String roomNumber;
  final String type;
  final double price;
  final String image;
  final String status; // 'Available', 'Booked', 'Occupied'
  final String? customerId; // ID of the customer who booked the room

  Room({
    required this.id,
    required this.roomNumber,
    required this.type,
    required this.price,
    required this.image,
    this.status = 'Available',
    this.customerId,
  });
} 