class ClothingItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final List<String> availableSizes;
  final List<int> availableColors;
  final bool isPopular;

  const ClothingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.imageUrl,
    required this.availableSizes,
    required this.availableColors,
    this.isPopular = false,
  });
}
