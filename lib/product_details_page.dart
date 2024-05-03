import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shopping_app/cart_provider.dart";

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int selectedSize = 0;
  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        "id": widget.product["id"],
        "title": widget.product["title"],
        "price": widget.product["price"],
        "size": selectedSize,
        "imageUrl": widget.product["imageUrl"],
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Succesfully added"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a size"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedSize = (widget.product["sizes"] as List<int>)[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Product Details"),
        ),
      ),
      body: Column(
        children: [
          Text(
            widget.product["title"] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product["imageUrl"] as String),
          ),
          const Spacer(flex: 2),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${widget.product["price"] as double}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product["sizes"] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product["sizes"] as List<int>)[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surfaceBright,
                            label: Text(
                              size.toString(),
                              style: TextStyle(
                                color: selectedSize == size
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: onTap,
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    label: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
