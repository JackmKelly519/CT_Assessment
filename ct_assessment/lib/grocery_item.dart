import 'package:equatable/equatable.dart';

class GroceryItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isSelected;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });

  GroceryItem copyWith({
    String? id,
    String? name,
    double? price,
    bool? isSelected,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, price, isSelected];
}
