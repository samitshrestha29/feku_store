// import 'package:feku_store/feku/controllers/search_controller.dart';
// import 'package:feku_store/feku/views/product_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:feku_store/feku/botttomNavigation/bottom_navigation.dart';
// import 'package:feku_store/feku/controllers/bottom_navigation_controller.dart';
// import 'package:feku_store/feku/views/bottom_navigation/shop_page.dart';
// import 'package:feku_store/feku/views/bottom_navigation/cart_page.dart';
// import 'package:feku_store/feku/views/bottom_navigation/favorites_page.dart';
// import 'package:feku_store/feku/views/bottom_navigation/profile_page.dart';

// class MyHomePage extends ConsumerStatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   ConsumerState<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends ConsumerState<MyHomePage>
//     with TickerProviderStateMixin {
//   bool showTextField = false;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isSearching = ref.watch(searchProvider.notifier).isSearching;
//     final selectedIndex = ref.watch(bottomNavProvider);

//     // List of pages to display based on the selected bottom navigation item
//     final List<Widget> pages = [
//       _buildHomePage(),
//       const ShopPage(),
//       const CartPage(),
//       const FavoritesPage(),
//       const ProfilePage(),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 4,
//         backgroundColor: Colors.blueAccent,
//         title: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: showTextField
//               ? _buildSearchField(context)
//               : const Text('Product Search'),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(showTextField ? Icons.close : Icons.search,
//                 color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 showTextField = !showTextField;
//                 if (!showTextField) {
//                   ref.read(searchProvider.notifier).clearSearchQuery();
//                   _searchController.clear();
//                 }
//               });
//             },
//           ),
//           if (isSearching)
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Colors.white,
//               ),
//             ),
//         ],
//       ),
//       body: pages[selectedIndex],
//       bottomNavigationBar: BottomNavigation(
//         selectedIndex: selectedIndex,
//         onItemTapped: (index) {
//           ref.read(bottomNavProvider.notifier).setIndex(index);
//         },
//       ),
//     );
//   }

//   Widget _buildSearchField(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Container(
//         height: 48,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search products...',
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
//             prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
//             suffixIcon: _searchController.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.grey),
//                     onPressed: () {
//                       _searchController.clear();
//                       ref.read(searchProvider.notifier).clearSearchQuery();
//                     },
//                   )
//                 : null,
//             contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
//             border: InputBorder.none,
//           ),
//           style: const TextStyle(color: Colors.black, fontSize: 16),
//           onChanged: (query) {
//             ref.read(searchProvider.notifier).setSearchQuery(query);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildHomePage() {
//     final searchState = ref.watch(searchProvider);
//     return searchState.when(
//       data: (products) {
//         if (products.isEmpty) {
//           return const Center(
//               child: Text('No products found.',
//                   style: TextStyle(fontSize: 18, color: Colors.grey)));
//         }
//         return GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 3 / 4,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(6),
//               child: ProductTile(productTile: products[index]),
//             );
//           },
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => Center(child: Text(error.toString())),
//     );
//   }
// }
