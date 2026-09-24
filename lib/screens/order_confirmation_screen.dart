import 'package:flutter/material.dart';
import 'order_tracking_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmed')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Order Placed Successfully!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Order Number: $orderId', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Estimated Pickup: 15-20 minutes', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderTrackingScreen(orderId: orderId),
                  ),
                );
              },
              child: const Text('Track Order'),
            ),
          ],
        ),
      ),
    );
  }
}