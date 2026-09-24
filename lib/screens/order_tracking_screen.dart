import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int statusIndex = 0;
  final List<String> statuses = ['Placed', 'Preparing', 'Ready for Pickup'];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Simulate order progressing through statuses automatically
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (statusIndex < statuses.length - 1) {
        setState(() => statusIndex++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order ${widget.orderId}')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...List.generate(statuses.length, (index) {
              final isDone = index <= statusIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isDone ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      statuses[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                        color: isDone ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                  );
                },
                child: const Text('Back to Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}