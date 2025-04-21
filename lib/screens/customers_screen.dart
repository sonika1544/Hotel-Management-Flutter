import 'package:flutter/material.dart';
import '../widgets/dashboard_layout.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardLayout(
      title: 'Customers',
      child: Center(
        child: Text('Customers Screen - Coming Soon'),
      ),
    );
  }
} 