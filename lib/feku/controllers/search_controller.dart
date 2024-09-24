import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

final searchProvider =
    StateNotifierProvider<SearchController, AsyncValue<List<Product>>>(
        (ref) => SearchController(ref.read(productServiceProvider)));

class SearchController extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductService productService;
  List<Product> allProducts = []; // Store all products here for filtering
  bool isSearching = false; // Track search status

  SearchController(this.productService) : super(const AsyncValue.loading()) {
    fetchAllProducts(); // Fetch all products initially
  }

  // Fetch all products from the API and store them
  Future<void> fetchAllProducts() async {
    try {
      final products = await productService.fetchProducts();
      allProducts = products;
      state = AsyncValue.data(allProducts); // Display all products initially
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Set the search query and start filtering
  void setSearchQuery(String query) {
    if (query.isNotEmpty) {
      isSearching = true; // Search is in progress
      searchProducts(query);
    } else {
      // Show all products if the query is empty
      isSearching = false;
      state = AsyncValue.data(allProducts);
    }
  }

  // Search and filter products based on the query
  void searchProducts(String query) async {
    try {
      final filteredProducts = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Update the state with filtered products
      if (filteredProducts.isNotEmpty) {
        state = AsyncValue.data(filteredProducts);
      } else {
        state = AsyncValue.error('Product Not Found', StackTrace.current);
      }
    } finally {
      isSearching = false; // Search finished
    }
  }

  // Clear the search query and display all products
  void clearSearchQuery() {
    state = AsyncValue.data(allProducts); // Reset to show all products
    isSearching = false;
  }
}
