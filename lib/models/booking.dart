
class Booking {
  final String id;
  final String roomId;
  final String customerId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final double totalPrice;
  final String status; // 'Active', 'Completed', 'Cancelled'

  Booking({
    required this.id,
    required this.roomId,
    required this.customerId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
    this.status = 'Active',
  });
} 