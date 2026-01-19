import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/shopping_list_bloc.dart';
import '../bloc/shopping_list_state.dart';
import '../bloc/shopping_list_event.dart';
import '/grocery_item_card.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShoppingListBloc>().add(const LoadInitialItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.green.shade700,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Shopping List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.green.shade700,
                          Colors.green.shade500,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.shopping_cart,
                        size: 80,
                        color: Colors.white24,
                      ),
                    ),
                  ),
                ),
              ),

              // Pinned Total Price Display
              SliverPersistentHeader(
                pinned: true,
                delegate: _TotalPriceDelegate(
                  totalPrice: state.totalPrice,
                  itemCount: state.items.where((item) => item.isSelected).length,
                ),
              ),

              // Grocery Items List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.items[index];
                    return GroceryItemCard(item: item);
                  },
                  childCount: state.items.length,
                ),
              ),

              // Bottom padding
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 24),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TotalPriceDelegate extends SliverPersistentHeaderDelegate {
  final double totalPrice;
  final int itemCount;

  _TotalPriceDelegate({
    required this.totalPrice,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 105.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant _TotalPriceDelegate oldDelegate) {
    return oldDelegate.totalPrice != totalPrice || 
           oldDelegate.itemCount != itemCount;
  }
}
