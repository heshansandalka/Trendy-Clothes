import 'clothing_item.dart';

class CartItem {
  final String id;
  final ClothingItem item;
  final String selectedSize;
  final int selectedColorHex;
  int quantity;

  CartItem({
    required this.id,
    required this.item,
    required this.selectedSize,
    required this.selectedColorHex,
    this.quantity = 1,
  });

  double get totalPrice => item.price * quantity;
}
