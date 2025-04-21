import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import '../widgets/dashboard_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeBookings = HotelData.getActiveBookings();
    final totalRooms = HotelData.rooms.length;
    final availableRooms = HotelData.rooms.where((room) => room.status == 'Available').length;
    final totalCustomers = HotelData.customers.length;
    final totalBookings = HotelData.bookings.length;

    return DashboardLayout(
      title: 'Dashboard',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Statistics Heading
            const Text(
              'Current Statistics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Statistics Cards
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildStatCard(
                  context,
                  'Total Rooms',
                  totalRooms.toString(),
                  Icons.hotel,
                  Colors.blue,
                ),
                _buildStatCard(
                  context,
                  'Available Rooms',
                  availableRooms.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildStatCard(
                  context,
                  'Total Customers',
                  totalCustomers.toString(),
                  Icons.people,
                  Colors.orange,
                ),
                _buildStatCard(
                  context,
                  'Total Bookings',
                  totalBookings.toString(),
                  Icons.book_online,
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Bookings Table Section
            Text(
              'Booking Records',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Booking ID')),
                    DataColumn(label: Text('Room')),
                    DataColumn(label: Text('Customer')),
                    DataColumn(label: Text('Check-in')),
                    DataColumn(label: Text('Check-out')),
                    DataColumn(label: Text('Total Price')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: HotelData.bookings.map((booking) {
                    final room = HotelData.rooms.firstWhere((r) => r.id == booking.roomId);
                    final customer = HotelData.customers.firstWhere((c) => c.id == booking.customerId);
                    
                    return DataRow(
                      cells: [
                        DataCell(Text(booking.id)),
                        DataCell(Text('${room.roomNumber} - ${room.type}')),
                        DataCell(Text(customer.name)),
                        DataCell(Text(
                          '${booking.checkInDate.day}/${booking.checkInDate.month}/${booking.checkInDate.year}',
                        )),
                        DataCell(Text(
                          '${booking.checkOutDate.day}/${booking.checkOutDate.month}/${booking.checkOutDate.year}',
                        )),
                        DataCell(Text(
                          '₹${booking.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: booking.status == 'Active'
                                  ? Colors.green
                                  : booking.status == 'Completed'
                                      ? Colors.blue
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              booking.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
} 