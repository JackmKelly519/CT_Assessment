import 'package:equatable/equatable.dart';
import '../grocery_item.dart';

class ShoppingListState extends Equatable {
  final List<GroceryItem> items;
  final double totalPrice;

  const ShoppingListState({
    this.items = const [],
    this.totalPrice = 0.0,
  });

  ShoppingListState copyWith({
    List<GroceryItem>? items,
    double? totalPrice,
  }) {
    return ShoppingListState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [items, totalPrice];
}
