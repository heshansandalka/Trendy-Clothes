import 'cart_item.dart';

enum OrderStatus { processing, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime date;
  final String shippingAddress;
  final String paymentMethod;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.shippingAddress,
    required this.paymentMethod,
    this.status = OrderStatus.processing,
  });
}
