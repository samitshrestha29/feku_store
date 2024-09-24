import 'package:feku_store/feku/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/product_service.dart';

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductService productService;

  ProductController(this.productService) : super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await productService.fetchProducts();
      state = AsyncValue.data(products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final productProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<Product>>>((ref) {
  return ProductController(ProductService());
});
