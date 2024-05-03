import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shopping_app/cart_provider.dart";

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Cart"),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final cartItem = cart[index];
            return ListTile(
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Product"),
                          content:
                              const Text("Do you want to remove this item?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .removeProduct(cartItem);

                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  cartItem["imageUrl"] as String,
                ),
              ),
              title: Text(
                cartItem["title"].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text("size ${cartItem["size"]}"),
            );
          },
          itemCount: cart.length,
        ));
  }
}
