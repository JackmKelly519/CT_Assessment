import 'package:equatable/equatable.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

class ToggleItemSelection extends ShoppingListEvent {
  final String itemId;

  const ToggleItemSelection(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class LoadInitialItems extends ShoppingListEvent {
  const LoadInitialItems();
}
