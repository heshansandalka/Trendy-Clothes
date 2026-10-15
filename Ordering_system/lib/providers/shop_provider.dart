import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_item.dart';
import '../models/cart_item.dart';
import '../models/order_model.dart';
import '../models/user_role.dart';
import '../data/mock_data.dart';

class ShopProvider extends ChangeNotifier {
  final List<ClothingItem> _allItems = List.from(mockClothingItems);
  final Set<String> _wishlistIds = {};
  final List<CartItem> _cartItems = [];
  final List<OrderModel> _orders = [];

  UserRole? _currentRole;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String? _appliedPromoCode;
  double _discountPercentage = 0.0;
  bool _isLoading = false;

  ShopProvider() {
    _loadDataFromFirestore();
  }

  // Auth / Role State
  UserRole? get currentRole => _currentRole;
  bool get isLoggedIn => _currentRole != null;
  bool get isAdmin => _currentRole == UserRole.admin;

  void loginAsCustomer() {
    _currentRole = UserRole.customer;
    notifyListeners();
  }

  void loginAsAdmin() {
    _currentRole = UserRole.admin;
    notifyListeners();
  }

  void logout() {
    _currentRole = null;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> _loadDataFromFirestore() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Load orders from Firestore if available
      final ordersSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('date', descending: true)
          .get();

      _orders.clear();
      _orders.addAll(
        ordersSnapshot.docs.map((doc) {
          final data = doc.data();
          return OrderModel(
            id: data['id'] ?? doc.id,
            items: [], // Parsed from items
            totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
            date: DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
            shippingAddress: data['shippingAddress'] ?? '',
            paymentMethod: data['paymentMethod'] ?? '',
            status: OrderStatus.values.firstWhere(
              (e) => e.name == data['status'],
              orElse: () => OrderStatus.processing,
            ),
          );
        }),
      );
    } catch (e) {
      debugPrint('Error loading Firestore data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Admin Catalog Management
  void addProduct(ClothingItem item) {
    _allItems.insert(0, item);
    // Sync to Firestore
    FirebaseFirestore.instance.collection('products').doc(item.id).set({
      'name': item.name,
      'category': item.category,
      'price': item.price,
      'rating': item.rating,
      'reviewCount': item.reviewCount,
      'description': item.description,
      'imageUrl': item.imageUrl,
      'isPopular': item.isPopular,
    }).then((_) {
      debugPrint('Product successfully added to Firestore!');
    }).catchError((error) {
      debugPrint('Failed to add product to Firestore: $error');
    });
    notifyListeners();
  }

  void updateProduct(ClothingItem updatedItem) {
    final index = _allItems.indexWhere((item) => item.id == updatedItem.id);
    if (index >= 0) {
      _allItems[index] = updatedItem;
      FirebaseFirestore.instance
          .collection('products')
          .doc(updatedItem.id)
          .update({
        'name': updatedItem.name,
        'category': updatedItem.category,
        'price': updatedItem.price,
        'description': updatedItem.description,
        'imageUrl': updatedItem.imageUrl,
        'isPopular': updatedItem.isPopular,
      });
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _allItems.removeWhere((item) => item.id == productId);
    _wishlistIds.remove(productId);
    _cartItems.removeWhere((item) => item.item.id == productId);
    FirebaseFirestore.instance.collection('products').doc(productId).delete();
    notifyListeners();
  }

  // Admin Order Status Management
  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      final oldOrder = _orders[index];
      final updatedOrder = OrderModel(
        id: oldOrder.id,
        items: oldOrder.items,
        totalAmount: oldOrder.totalAmount,
        date: oldOrder.date,
        shippingAddress: oldOrder.shippingAddress,
        paymentMethod: oldOrder.paymentMethod,
        status: newStatus,
      );
      _orders[index] = updatedOrder;

      FirebaseFirestore.instance.collection('orders').doc(orderId).update({
        'status': newStatus.name,
      });

      notifyListeners();
    }
  }

  // Admin Dashboard Stats
  double get totalRevenue {
    return _orders.fold(
      0.0,
      (totalRevenueVal, order) => totalRevenueVal + order.totalAmount,
    );
  }

  int get pendingOrdersCount {
    return _orders.where((o) => o.status == OrderStatus.processing).length;
  }

  // Getters
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  Set<String> get wishlistIds => _wishlistIds;
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  List<OrderModel> get orders => List.unmodifiable(_orders);
  String? get appliedPromoCode => _appliedPromoCode;
  double get discountPercentage => _discountPercentage;

  List<ClothingItem> get items {
    return _allItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch =
          _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<ClothingItem> get allItemsCatalog => List.unmodifiable(_allItems);

  List<ClothingItem> get popularItems {
    return _allItems.where((item) => item.isPopular).toList();
  }

  List<ClothingItem> get wishlistedItems {
    return _allItems.where((item) => _wishlistIds.contains(item.id)).toList();
  }

  int get cartCount {
    return _cartItems.fold(0, (totalCount, item) => totalCount + item.quantity);
  }

  double get subtotal {
    return _cartItems.fold(
      0.0,
      (totalPriceVal, item) => totalPriceVal + item.totalPrice,
    );
  }

  double get shippingFee {
    if (_cartItems.isEmpty) return 0.0;
    return subtotal > 100.0 ? 0.0 : 5.99;
  }

  double get discountAmount {
    return subtotal * _discountPercentage;
  }

  double get grandTotal {
    if (_cartItems.isEmpty) return 0.0;
    return subtotal - discountAmount + shippingFee;
  }

  // Category & Search
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Wishlist
  bool isWishlisted(String productId) {
    return _wishlistIds.contains(productId);
  }

  Future<void> toggleWishlist(String productId) async {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  // Cart Management
  Future<void> addToCart(
    ClothingItem item, {
    required String selectedSize,
    required int selectedColorHex,
    int quantity = 1,
  }) async {
    final index = _cartItems.indexWhere(
      (cartItem) =>
          cartItem.item.id == item.id &&
          cartItem.selectedSize == selectedSize &&
          cartItem.selectedColorHex == selectedColorHex,
    );

    if (index >= 0) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          item: item,
          selectedSize: selectedSize,
          selectedColorHex: selectedColorHex,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  Future<void> updateCartQuantity(String cartItemId, int newQuantity) async {
    final index = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    _appliedPromoCode = null;
    _discountPercentage = 0.0;
    notifyListeners();
  }

  // Promo Code
  bool applyPromoCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'SAVE10') {
      _appliedPromoCode = 'SAVE10';
      _discountPercentage = 0.10;
      notifyListeners();
      return true;
    } else if (cleanCode == 'WELCOME20') {
      _appliedPromoCode = 'WELCOME20';
      _discountPercentage = 0.20;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    _discountPercentage = 0.0;
    notifyListeners();
  }

  // Checkout & Order Placement
  OrderModel placeOrder({
    required String shippingAddress,
    required String paymentMethod,
  }) {
    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      items: List.from(_cartItems),
      totalAmount: grandTotal,
      date: DateTime.now(),
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
      status: OrderStatus.processing,
    );

    _orders.insert(0, order);

    // Save order to Firestore
    FirebaseFirestore.instance.collection('orders').doc(order.id).set({
      'id': order.id,
      'totalAmount': order.totalAmount,
      'date': order.date.toIso8601String(),
      'shippingAddress': order.shippingAddress,
      'paymentMethod': order.paymentMethod,
      'status': order.status.name,
    }).then((_) {
      debugPrint('Order successfully written to Firestore!');
    }).catchError((error) {
      debugPrint('Failed to write order to Firestore: $error');
    });

    clearCart();
    notifyListeners();
    return order;
  }
}
