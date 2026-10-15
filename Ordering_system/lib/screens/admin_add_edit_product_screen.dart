import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../providers/shop_provider.dart';

class AdminAddEditProductScreen extends StatefulWidget {
  final ShopProvider provider;
  final ClothingItem? itemToEdit;

  const AdminAddEditProductScreen({
    super.key,
    required this.provider,
    this.itemToEdit,
  });

  @override
  State<AdminAddEditProductScreen> createState() =>
      _AdminAddEditProductScreenState();
}

class _AdminAddEditProductScreenState extends State<AdminAddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  late TextEditingController _descriptionController;

  bool _isPopular = false;

  @override
  void initState() {
    super.initState();
    final item = widget.itemToEdit;
    _nameController = TextEditingController(text: item?.name ?? '');
    _categoryController = TextEditingController(
      text: item?.category ?? 'T-Shirts',
    );
    _priceController = TextEditingController(
      text: item != null ? item.price.toString() : '',
    );
    _imageUrlController = TextEditingController(
      text:
          item?.imageUrl ??
          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop',
    );
    _descriptionController = TextEditingController(
      text: item?.description ?? '',
    );
    _isPopular = item?.isPopular ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.itemToEdit != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Clothing Item' : 'Add New Cloth'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Clothing Name',
                  prefixIcon: Icon(Icons.checkroom),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 12),

              // Category & Price
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter category'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Price (\$)',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter price';
                        if (double.tryParse(val) == null) {
                          return 'Invalid price';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Image URL
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter image URL'
                    : null,
              ),
              const SizedBox(height: 12),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter description'
                    : null,
              ),
              const SizedBox(height: 12),

              // Is Popular Switch
              SwitchListTile(
                title: const Text('Mark as HOT / Popular'),
                value: _isPopular,
                activeThumbColor: Theme.of(context).primaryColor,
                onChanged: (val) => setState(() => _isPopular = val),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final item = ClothingItem(
                        id:
                            widget.itemToEdit?.id ??
                            'c_${DateTime.now().millisecondsSinceEpoch}',
                        name: _nameController.text.trim(),
                        category: _categoryController.text.trim(),
                        price: double.parse(_priceController.text.trim()),
                        rating: widget.itemToEdit?.rating ?? 4.8,
                        reviewCount: widget.itemToEdit?.reviewCount ?? 1,
                        description: _descriptionController.text.trim(),
                        imageUrl: _imageUrlController.text.trim(),
                        availableSizes:
                            widget.itemToEdit?.availableSizes ??
                            ['S', 'M', 'L', 'XL'],
                        availableColors:
                            widget.itemToEdit?.availableColors ??
                            [0xFF2C3E50, 0xFF000000],
                        isPopular: _isPopular,
                      );

                      if (isEditing) {
                        widget.provider.updateProduct(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cloth updated successfully!'),
                          ),
                        );
                      } else {
                        widget.provider.addProduct(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('New cloth added successfully!'),
                          ),
                        );
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    isEditing ? 'Save Changes' : 'Add Clothing Item',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
