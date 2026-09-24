import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple sample order history for demo purposes
    final orderHistory = [
      {'id': 'QB48213', 'items': 'Chicken Rice, Iced Coffee', 'total': 'Rs. 700'},
      {'id': 'QB39871', 'items': 'French Fries', 'total': 'Rs. 300'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text('Kasun Perera', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('Student ID: IT21XXXXXX', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('Order History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  return Card(
                    child: ListTile(
                      title: Text('Order ${order['id']}'),
                      subtitle: Text(order['items']!),
                      trailing: Text(order['total']!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}