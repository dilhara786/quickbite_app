import 'package:flutter/material.dart';
import 'item_detail_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MenuItem {
  final String name;
  final String category;
  final double price;
  final IconData icon;

  MenuItem({
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
  });
}

final List<MenuItem> menuItems = [
  MenuItem(name: 'Chicken Rice', category: 'Meals', price: 450, icon: Icons.rice_bowl),
  MenuItem(name: 'Vegetable Kottu', category: 'Meals', price: 400, icon: Icons.dinner_dining),
  MenuItem(name: 'Iced Coffee', category: 'Beverages', price: 250, icon: Icons.local_cafe),
  MenuItem(name: 'Fresh Juice', category: 'Beverages', price: 200, icon: Icons.local_drink),
  MenuItem(name: 'French Fries', category: 'Snacks', price: 300, icon: Icons.fastfood),
  MenuItem(name: 'Chicken Rolls', category: 'Snacks', price: 150, icon: Icons.lunch_dining),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Meals', 'Beverages', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'All' || item.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBite Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search menu...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => selectedCategory = cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(item: item),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: 50, color: Colors.orange),
                          const SizedBox(height: 8),
                          Text(item.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Rs. ${item.price.toStringAsFixed(0)}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}