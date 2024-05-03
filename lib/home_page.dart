import "package:flutter/material.dart";
import "package:shopping_app/cart_page.dart";
import "package:shopping_app/product_list.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int currentPage = 0;
  List<Widget> pages = const [
    ProductList(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_sharp,
            ),
            label: "",
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
    );
  }
}
