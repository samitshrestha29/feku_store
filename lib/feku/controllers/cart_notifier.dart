import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  // Add product to the cart
  void addToCart(Product product) {
    // Only add if the product is not already in the cart
    if (!state.contains(product)) {
      state = [...state, product]; // Update state with the new product
    }
  }

  // Remove product from the cart
  void removeFromCart(Product product) {
    state = state
        .where((p) => p.id != product.id)
        .toList(); // Remove the product from state
  }

  // Clear all products from the cart
  void clearCart() {
    state = []; // Clear the cart
  }
}

// Provide the CartNotifier using Riverpod
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});
