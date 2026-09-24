import 'home_screen.dart';

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get subtotal => item.price * quantity;
}

class Cart {
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  final List<CartItem> items = [];

  void addItem(MenuItem item, int quantity) {
    final existing = items.where((c) => c.item.name == item.name).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += quantity;
    } else {
      items.add(CartItem(item: item, quantity: quantity));
    }
  }

  double get total => items.fold(0, (sum, c) => sum + c.subtotal);
  int get itemCount => items.fold(0, (sum, c) => sum + c.quantity);

  void clear() => items.clear();
}