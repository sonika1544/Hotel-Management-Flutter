import 'package:flutter/material.dart';
import '../models/room.dart';
import '../models/customer.dart';
import '../models/booking.dart';
import '../data/hotel_data.dart';
import '../widgets/dashboard_layout.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  void _showAddRoomDialog() {
    final TextEditingController roomNumberController = TextEditingController();
    String selectedType = HotelData.roomTypes.keys.first;
    final TextEditingController priceController = TextEditingController(
      text: HotelData.roomTypes[selectedType]?.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add New Room'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: roomNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Room Number',
                    hintText: 'Enter room number',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Room Type',
                  ),
                  items: HotelData.roomTypes.keys.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text('$type (Min: ₹${HotelData.roomTypes[type]?.toStringAsFixed(0)})'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedType = newValue;
                        priceController.text = HotelData.roomTypes[newValue]?.toString() ?? '';
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price per Night',
                    hintText: 'Enter price',
                    helperText: 'Minimum price: ₹${HotelData.roomTypes[selectedType]?.toStringAsFixed(0)}',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (roomNumberController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  final price = double.tryParse(priceController.text);
                  if (price != null && price >= (HotelData.roomTypes[selectedType] ?? 0)) {
                    this.setState(() {
                      HotelData.rooms.add(
                        Room(
                          id: 'R${(HotelData.rooms.length + 1).toString().padLeft(3, '0')}',
                          roomNumber: roomNumberController.text,
                          type: selectedType,
                          price: price,
                          image: 'assets/images/${selectedType.toLowerCase().replaceAll(' ', '')}.png',
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Add Room'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditRoomDialog(Room room) {
    final TextEditingController roomNumberController = TextEditingController(text: room.roomNumber);
    String selectedType = room.type;
    final TextEditingController priceController = TextEditingController(text: room.price.toString());

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Room'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: roomNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Room Number',
                    hintText: 'Enter room number',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Room Type',
                  ),
                  items: HotelData.roomTypes.keys.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text('$type (Min: ₹${HotelData.roomTypes[type]?.toStringAsFixed(0)})'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedType = newValue;
                        priceController.text = HotelData.roomTypes[newValue]?.toString() ?? '';
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price per Night',
                    hintText: 'Enter price',
                    helperText: 'Minimum price: ₹${HotelData.roomTypes[selectedType]?.toStringAsFixed(0)}',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (roomNumberController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  final price = double.tryParse(priceController.text);
                  if (price != null && price >= (HotelData.roomTypes[selectedType] ?? 0)) {
                    this.setState(() {
                      final roomIndex = HotelData.rooms.indexWhere((r) => r.id == room.id);
                      if (roomIndex != -1) {
                        HotelData.rooms[roomIndex] = Room(
                          id: room.id,
                          roomNumber: roomNumberController.text,
                          type: selectedType,
                          price: price,
                          image: 'assets/images/${selectedType.toLowerCase().replaceAll(' ', '')}.png',
                          status: room.status,
                          customerId: room.customerId,
                        );
                      }
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Room room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Room'),
        content: Text('Are you sure you want to delete Room ${room.roomNumber}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                HotelData.rooms.removeWhere((r) => r.id == room.id);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showBookingDialog(Room room) {
    String? selectedCustomerId;
    Customer? selectedCustomer;
    DateTime checkInDate = DateTime.now();
    DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Book Room'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Room ${room.roomNumber} - ${room.type}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCustomerId,
                  decoration: const InputDecoration(
                    labelText: 'Select Customer',
                    border: OutlineInputBorder(),
                  ),
                  items: HotelData.customers.map((Customer customer) {
                    return DropdownMenuItem<String>(
                      value: customer.id,
                      child: Text('${customer.name} (${customer.id})'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedCustomerId = newValue;
                        selectedCustomer = HotelData.customers
                            .firstWhere((c) => c.id == newValue);
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Check-in Date'),
                  subtitle: Text(
                    '${checkInDate.day}/${checkInDate.month}/${checkInDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: checkInDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        checkInDate = date;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text('Check-out Date'),
                  subtitle: Text(
                    '${checkOutDate.day}/${checkOutDate.month}/${checkOutDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: checkOutDate,
                      firstDate: checkInDate.add(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        checkOutDate = date;
                      });
                    }
                  },
                ),
                if (selectedCustomer != null) ...[
                  const SizedBox(height: 16),
                  const Text('Customer Details:'),
                  Text('Email: ${selectedCustomer!.email}'),
                  Text('Phone: ${selectedCustomer!.mobileNumber}'),
                ],
                const SizedBox(height: 16),
                Text(
                  'Total Price: ₹${_calculateTotalPrice(room.price, checkInDate, checkOutDate).toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedCustomerId == null
                  ? null
                  : () {
                      final totalPrice = _calculateTotalPrice(room.price, checkInDate, checkOutDate);
                      final booking = Booking(
                        id: 'B${(HotelData.bookings.length + 1).toString().padLeft(3, '0')}',
                        roomId: room.id,
                        customerId: selectedCustomerId!,
                        checkInDate: checkInDate,
                        checkOutDate: checkOutDate,
                        totalPrice: totalPrice,
                      );
                      
                      this.setState(() {
                        HotelData.addBooking(booking);
                        final roomIndex = HotelData.rooms.indexWhere((r) => r.id == room.id);
                        if (roomIndex != -1) {
                          HotelData.rooms[roomIndex] = Room(
                            id: room.id,
                            roomNumber: room.roomNumber,
                            type: room.type,
                            price: room.price,
                            image: room.image,
                            status: 'Booked',
                            customerId: selectedCustomerId,
                          );
                        }
                      });
                      Navigator.pop(context);
                    },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalPrice(double pricePerNight, DateTime checkIn, DateTime checkOut) {
    final nights = checkOut.difference(checkIn).inDays;
    return pricePerNight * nights;
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Rooms',
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoomDialog,
        child: const Icon(Icons.add),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: HotelData.rooms.length,
        itemBuilder: (context, index) {
          final room = HotelData.rooms[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset(
                        room.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditRoomDialog(room);
                            } else if (value == 'delete') {
                              _showDeleteConfirmationDialog(room);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Room ${room.roomNumber}',
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: room.status == 'Available'
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                room.status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          room.type,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${room.price.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: room.status == 'Available'
                                ? () => _showBookingDialog(room)
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: Text(
                              room.status == 'Available' ? 'Book Now' : 'Booked',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 