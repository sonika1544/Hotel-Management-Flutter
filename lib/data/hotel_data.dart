import '../models/customer.dart';
import '../models/room.dart';
import '../models/booking.dart';

class HotelData {
  static final List<Customer> customers = [
    Customer(
      id: 'C001',
      name: 'Rajesh Kumar',
      email: 'rajesh.kumar@email.com',
      mobileNumber: '9876543210',
      address: '123, Main Street, Mumbai, Maharashtra',
      dateOfBirth: DateTime(1990, 5, 15),
    ),
    Customer(
      id: 'C002',
      name: 'Priya Sharma',
      email: 'priya.sharma@email.com',
      mobileNumber: '8765432109',
      address: '456, Park Road, Delhi, Delhi',
      dateOfBirth: DateTime(1988, 8, 22),
    ),
    Customer(
      id: 'C003',
      name: 'Amit Patel',
      email: 'amit.patel@email.com',
      mobileNumber: '7654321098',
      address: '789, Lake View, Bangalore, Karnataka',
      dateOfBirth: DateTime(1992, 3, 10),
    ),
    Customer(
      id: 'C004',
      name: 'Neha Gupta',
      email: 'neha.gupta@email.com',
      mobileNumber: '6543210987',
      address: '321, Hill Road, Pune, Maharashtra',
      dateOfBirth: DateTime(1995, 11, 30),
    ),
    Customer(
      id: 'C005',
      name: 'Suresh Verma',
      email: 'suresh.verma@email.com',
      mobileNumber: '5432109876',
      address: '654, Garden Street, Chennai, Tamil Nadu',
      dateOfBirth: DateTime(1985, 7, 18),
    ),
    Customer(
      id: 'C006',
      name: 'Anita Desai',
      email: 'anita.desai@email.com',
      mobileNumber: '4321098765',
      address: '987, Beach Road, Kochi, Kerala',
      dateOfBirth: DateTime(1993, 4, 25),
    ),
    Customer(
      id: 'C007',
      name: 'Vikram Singh',
      email: 'vikram.singh@email.com',
      mobileNumber: '3210987654',
      address: '147, River Side, Hyderabad, Telangana',
      dateOfBirth: DateTime(1987, 9, 12),
    ),
    Customer(
      id: 'C008',
      name: 'Meera Reddy',
      email: 'meera.reddy@email.com',
      mobileNumber: '2109876543',
      address: '258, Forest Lane, Kolkata, West Bengal',
      dateOfBirth: DateTime(1991, 6, 8),
    ),
    Customer(
      id: 'C009',
      name: 'Arun Malhotra',
      email: 'arun.malhotra@email.com',
      mobileNumber: '1098765432',
      address: '369, Valley View, Ahmedabad, Gujarat',
      dateOfBirth: DateTime(1989, 2, 14),
    ),
    Customer(
      id: 'C010',
      name: 'Deepa Joshi',
      email: 'deepa.joshi@email.com',
      mobileNumber: '0987654321',
      address: '741, Mountain Road, Jaipur, Rajasthan',
      dateOfBirth: DateTime(1994, 12, 3),
    ),
  ];

  static final List<Room> rooms = [
    Room(
      id: 'R001',
      roomNumber: '101',
      type: 'Standard Room',
      price: 10000,
      image: 'assets/images/standard.png',
    ),
    Room(
      id: 'R002',
      roomNumber: '102',
      type: 'Deluxe Room',
      price: 15000,
      image: 'assets/images/deluxe.png',
    ),
    Room(
      id: 'R003',
      roomNumber: '201',
      type: 'Suite',
      price: 25000,
      image: 'assets/images/suite.png',
    ),
    Room(
      id: 'R004',
      roomNumber: '202',
      type: 'Family Suite',
      price: 30000,
      image: 'assets/images/family.png',
    ),
    Room(
      id: 'R005',
      roomNumber: '301',
      type: 'Executive Suite',
      price: 35000,
      image: 'assets/images/executive.png',
    ),
    Room(
      id: 'R006',
      roomNumber: '302',
      type: 'Penthouse Suite',
      price: 50000,
      image: 'assets/images/penthouse.png',
    ),
    Room(
      id: 'R007',
      roomNumber: '401',
      type: 'Presidential Suite',
      price: 80000,
      image: 'assets/images/presidential.png',
    ),
    Room(
      id: 'R008',
      roomNumber: '402',
      type: 'Deluxe Room',
      price: 15000,
      image: 'assets/images/deluxe.png',
    ),
    Room(
      id: 'R009',
      roomNumber: '501',
      type: 'Suite',
      price: 25000,
      image: 'assets/images/suite.png',
    ),
  ];

  static List<Booking> bookings = [];

  static Map<String, double> roomTypes = {
    'Standard Room': 10000,
    'Deluxe Room': 15000,
    'Suite': 25000,
    'Family Suite': 30000,
    'Executive Suite': 35000,
    'Penthouse Suite': 50000,
    'Presidential Suite': 80000,
  };

  static void addBooking(Booking booking) {
    bookings.add(booking);
  }

  static List<Booking> getActiveBookings() {
    return bookings.where((booking) => booking.status == 'Active').toList();
  }

  static List<Booking> getBookingsByRoom(String roomId) {
    return bookings.where((booking) => booking.roomId == roomId).toList();
  }

  static List<Booking> getBookingsByCustomer(String customerId) {
    return bookings.where((booking) => booking.customerId == customerId).toList();
  }
} 