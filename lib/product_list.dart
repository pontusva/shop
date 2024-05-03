import "package:flutter/material.dart";
import "package:shopping_app/global_variables.dart";
import "package:shopping_app/product_card.dart";
import "package:shopping_app/product_details_page.dart";

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    "All",
    "Adidas",
    "Nike",
    "Bata",
  ];
  late String selectedFilters;
  @override
  void initState() {
    super.initState();
    selectedFilters = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(25),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text("Shoe\nCollection",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilters = filters[index];
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilters == filter
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        filter,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                final products = product[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ProductDetailsPage(product: products);
                      }),
                    );
                  },
                  child: ProductCard(
                    title: products["title"] as String,
                    price: products["price"] as double,
                    image: products["imageUrl"] as String,
                    backgroundColor: index.isEven
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
