import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feku_store/feku/controllers/favorites_notifier.dart';
import 'package:feku_store/feku/controllers/cart_notifier.dart'; // Import the CartNotifier

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.grey.shade200,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No favorite products'))
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            product.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "\$${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // Remove item from favorites (X icon)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .toggleFavorite(product);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Cart icon below the X icon
                        Positioned(
                          top: 48, // Positioned below the X icon
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              // Add to cart when cart icon is pressed
                              ref
                                  .read(cartProvider.notifier)
                                  .addToCart(product);

                              // Show a confirmation message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("${product.title} added to cart")),
                              );
                            },
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
