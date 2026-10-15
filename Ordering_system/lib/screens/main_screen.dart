import 'package:flutter/material.dart';
import '../providers/shop_provider.dart';
import 'home_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';

class MainScreen extends StatefulWidget {
  final ShopProvider provider;

  const MainScreen({super.key, required this.provider});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    final List<Widget> pages = [
      HomeScreen(provider: provider),
      WishlistScreen(
        provider: provider,
        onExplore: () => setState(() => _currentIndex = 0),
      ),
      CartScreen(
        provider: provider,
        onExplore: () => setState(() => _currentIndex = 0),
      ),
      OrdersScreen(provider: provider),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: provider.wishlistIds.isNotEmpty,
                label: Text('${provider.wishlistIds.length}'),
                child: const Icon(Icons.favorite_border),
              ),
              activeIcon: Badge(
                isLabelVisible: provider.wishlistIds.isNotEmpty,
                label: Text('${provider.wishlistIds.length}'),
                child: const Icon(Icons.favorite),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: provider.cartCount > 0,
                label: Text('${provider.cartCount}'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: provider.cartCount > 0,
                label: Text('${provider.cartCount}'),
                child: const Icon(Icons.shopping_bag),
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }
}
