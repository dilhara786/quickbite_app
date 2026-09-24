import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Cart();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: cart.items.map((c) {
                  return ListTile(
                    title: Text(c.item.name),
                    subtitle: Text('Qty: ${c.quantity}'),
                    trailing: Text('Rs. ${c.subtotal.toStringAsFixed(0)}'),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Rs. ${cart.total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final orderId = 'QB${DateTime.now().millisecondsSinceEpoch % 100000}';
                cart.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmationScreen(orderId: orderId),
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}