import 'package:flutter/material.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  final ShopProvider provider;
  final VoidCallback onExplore;

  const WishlistScreen({
    super.key,
    required this.provider,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistedItems = provider.wishlistedItems;

    if (wishlistedItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 96,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your Wishlist is Empty',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Save your favorite clothing items here by clicking the heart icon while exploring.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onExplore,
                  child: const Text(
                    'Explore Clothes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('My Wishlist (${wishlistedItems.length})'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: wishlistedItems.length,
        itemBuilder: (context, index) {
          final item = wishlistedItems[index];
          return ProductCard(
            item: item,
            isWishlisted: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      ProductDetailScreen(item: item, provider: provider),
                ),
              );
            },
            onFavoriteToggle: () {
              provider.toggleWishlist(item.id);
            },
          );
        },
      ),
    );
  }
}
