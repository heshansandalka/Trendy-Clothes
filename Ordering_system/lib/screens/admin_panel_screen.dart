import 'package:flutter/material.dart';
import '../providers/shop_provider.dart';
import '../models/order_model.dart';
import 'admin_add_edit_product_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  final ShopProvider provider;

  const AdminPanelScreen({super.key, required this.provider});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Colors.black87),
            SizedBox(width: 8),
            Text('Admin Management Panel'),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout Admin',
            onPressed: () {
              provider.logout();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildOverviewTab(provider),
          _buildCatalogTab(provider),
          _buildOrdersTab(provider),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
        ],
      ),
      floatingActionButton: _selectedTab == 1
          ? FloatingActionButton.extended(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add Cloth',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) =>
                        AdminAddEditProductScreen(provider: provider),
                  ),
                );
              },
            )
          : null,
    );
  }

  // --- Overview Dashboard Tab ---
  Widget _buildOverviewTab(ShopProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales & System Stats',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Stat Cards Grid
          Row(
            children: [
              Expanded(
                child: _statCard(
                  'Total Revenue',
                  '\$${provider.totalRevenue.toStringAsFixed(2)}',
                  Icons.attach_money,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  'Total Orders',
                  '${provider.orders.length}',
                  Icons.receipt_long,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  'Pending Orders',
                  '${provider.pendingOrdersCount}',
                  Icons.hourglass_top,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  'Catalog Items',
                  '${provider.allItemsCatalog.length}',
                  Icons.checkroom,
                  Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Quick Management Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Colors.white,
            leading: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Icon(Icons.add_business, color: Colors.black),
            ),
            title: const Text('Add New Clothing Item'),
            subtitle: const Text('Add new t-shirt, jacket, or shoes to shop'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      AdminAddEditProductScreen(provider: provider),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Colors.white,
            leading: const CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.local_shipping, color: Colors.white),
            ),
            title: const Text('Manage Customer Orders'),
            subtitle: const Text('Update order status (Processing, Shipped)'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => setState(() => _selectedTab = 2),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withAlpha(30),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // --- Catalog Management Tab ---
  Widget _buildCatalogTab(ShopProvider provider) {
    final catalog = provider.allItemsCatalog;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: catalog.length,
      separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = catalog[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.checkroom),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${item.category} • \$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => AdminAddEditProductScreen(
                        provider: provider,
                        itemToEdit: item,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete Clothing Item?'),
                      content: Text(
                        'Are you sure you want to delete ${item.name}?',
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        TextButton(
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            provider.deleteProduct(item.id);
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Customer Orders Management Tab ---
  Widget _buildOrdersTab(ShopProvider provider) {
    final orders = provider.orders;

    if (orders.isEmpty) {
      return const Center(child: Text('No customer orders placed yet.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (ctx, idx) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.id,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<OrderStatus>(
                    value: order.status,
                    underline: const SizedBox(),
                    items: OrderStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(
                          status.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        provider.updateOrderStatus(order.id, newStatus);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Address: ${order.shippingAddress}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              Text(
                'Payment: ${order.paymentMethod}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.items.length} items',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
