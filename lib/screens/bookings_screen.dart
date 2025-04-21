import 'package:flutter/material.dart';
import '../widgets/dashboard_layout.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardLayout(
      title: 'Bookings',
      child: Center(
        child: Text('Bookings Screen - Coming Soon'),
      ),
    );
  }
}
