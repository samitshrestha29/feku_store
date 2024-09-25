import 'package:feku_store/feku/controllers/favorites_notifier.dart';
import 'package:feku_store/feku/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Product detailProduct;

  const ProductDetailPage({super.key, required this.detailProduct});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Check if the product is already in favorites
    final isFavorited = ref
        .watch(favoritesProvider)
        .any((product) => product.id == widget.detailProduct.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : Colors.black,
            ),
            onPressed: () {
              // Toggle favorite state
              ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(widget.detailProduct);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product Image
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      widget.detailProduct.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Product Title and Favorite Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.detailProduct.title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(widget.detailProduct);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),

                // Product Price
                Text(
                  '£${widget.detailProduct.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8.0),

                // Ratings and Sold Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.detailProduct.rate}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.detailProduct.count} sold',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Description with 'See More' button
                Text(
                  isExpanded
                      ? widget.detailProduct.description
                      : widget.detailProduct.description.length > 100
                          ? '${widget.detailProduct.description.substring(0, 100)}...'
                          : widget.detailProduct.description,
                  style: const TextStyle(fontSize: 16.0),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? 'See Less' : 'See More',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 100), // Spacing for the bottom buttons
              ],
            ),
          ),

          // Add to Cart and Buy Now Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Add to Cart Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        // Handle add to cart action
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),

                  // Buy Now Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        // Handle buy now action
                      },
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
