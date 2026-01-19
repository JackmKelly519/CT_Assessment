import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/grocery_item.dart';
import '../bloc/shopping_list_bloc.dart';
import '../bloc/shopping_list_event.dart';
import '/audio_service.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  final AudioService audioService = AudioService();

  GroceryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: item.isSelected ? 4 : 1,
      color: item.isSelected ? Colors.green.shade50 : Colors.white,
      child: InkWell(
        onTap: () {
          if (item.isSelected) {
            audioService.playDeselectSound();
          } else {
            audioService.playSelectSound();
          }
          
          // Toggle selection
          context.read<ShoppingListBloc>().add(ToggleItemSelection(item.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: item.isSelected,
                onChanged: (bool? value) {
                  if (item.isSelected) {
                    audioService.playDeselectSound();
                  } else {
                    audioService.playSelectSound();
                  }
                  context.read<ShoppingListBloc>().add(ToggleItemSelection(item.id));
                },
                activeColor: Colors.green,
              ),
              const SizedBox(width: 12),
              
              // Item name and price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: item.isSelected
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: item.isSelected ? Colors.grey : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: item.isSelected ? Colors.grey : Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
