import 'package:feku_store/controllers/bottom_navigation_controller.dart';
import 'package:feku_store/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/product_controller.dart';
import 'product_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    void onItemTapped(int index) {
      ref.read(bottomNavProvider.notifier).setIndex(index);
    }

    // List of pages for each tab
    final List<Widget> pages = [
      _buildHomePage(ref), // Home (Product Grid)
      _buildShopPage(), // Shop (Placeholder)
      _buildCartPage(), // Cart (Placeholder)
      _buildFavoritesPage(), // Favorites (Placeholder)
      _buildProfilePage(), // Profile (Placeholder)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: pages[selectedIndex], // Show content based on selected index
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }

  Widget _buildHomePage(WidgetRef ref) {
    final productState = ref.watch(productProvider);
    return productState.when(
      data: (products) => SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(6),
              child: ProductTile(productTile: products[index]),
            );
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(
        child: Text('Error: $e'),
      ),
    );
  }

  // Placeholder pages for Shop, Cart, Favorites, Profile
  Widget _buildShopPage() {
    return const Center(
      child: Text(
        'Shop Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildCartPage() {
    return const Center(
      child: Text(
        'Cart Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildFavoritesPage() {
    return const Center(
      child: Text(
        'Favorites Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildProfilePage() {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
