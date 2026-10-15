import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelectCategory;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: mockCategories.length,
        itemBuilder: (context, index) {
          final category = mockCategories[index];
          final isSelected =
              category.toLowerCase() == selectedCategory.toLowerCase();

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(category),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              backgroundColor: Colors.grey.shade100,
              selectedColor: Theme.of(context).primaryColor,
              checkmarkColor: Colors.white,
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              onSelected: (_) => onSelectCategory(category),
            ),
          );
        },
      ),
    );
  }
}
