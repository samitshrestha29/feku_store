import 'package:feku_store/feku/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    // Here you can fetch products by their IDs and update the state.
    // Example: `state = fetchedProductsFromIds;`
  }

  Future<void> toggleFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorite_ids') ?? [];

    if (favoriteIds.contains(product.id.toString())) {
      // If the product is already a favorite, remove it from the list
      favoriteIds.remove(product.id.toString());
      state = state
          .where((p) => p.id != product.id)
          .toList(); // Remove product from state
    } else {
      // If not a favorite, add it
      favoriteIds.add(product.id.toString());
      state = [...state, product]; // Add product to state
    }

    prefs.setStringList(
        'favorite_ids', favoriteIds); // Update SharedPreferences
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  final notifier = FavoritesNotifier();
  notifier.loadFavorites(); // Load favorites when the provider is initialized.
  return notifier;
});
