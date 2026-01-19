import 'package:flutter_bloc/flutter_bloc.dart';
import '../grocery_item.dart';
import 'shopping_list_event.dart';
import 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(const ShoppingListState()) {
    on<LoadInitialItems>(_onLoadInitialItems);
    on<ToggleItemSelection>(_onToggleItemSelection);
  }

  void _onLoadInitialItems(
    LoadInitialItems event,
    Emitter<ShoppingListState> emit,
  ) {
    final items = [
      const GroceryItem(id: '1', name: 'Apples', price: 3.99),
      const GroceryItem(id: '2', name: 'Bread', price: 2.49),
      const GroceryItem(id: '3', name: 'Milk', price: 4.29),
      const GroceryItem(id: '4', name: 'Eggs', price: 5.99),
      const GroceryItem(id: '5', name: 'Cheese', price: 6.49),
      const GroceryItem(id: '6', name: 'Chicken', price: 8.99),
      const GroceryItem(id: '7', name: 'Rice', price: 4.79),
      const GroceryItem(id: '8', name: 'Pasta', price: 3.29),
      const GroceryItem(id: '9', name: 'Tomatoes', price: 3.49),
      const GroceryItem(id: '10', name: 'Coffee', price: 12.99),
    ];

    emit(state.copyWith(items: items, totalPrice: 0.0));
  }

  void _onToggleItemSelection(
    ToggleItemSelection event,
    Emitter<ShoppingListState> emit,
  ) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();

    final total = updatedItems
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + item.price);

    emit(state.copyWith(items: updatedItems, totalPrice: total));
  }
}
