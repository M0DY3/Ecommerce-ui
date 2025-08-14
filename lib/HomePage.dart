import 'package:flutter/material.dart';
import 'package:flutter_course/CartPage.dart';
import 'package:flutter_course/account.dart';
import 'package:flutter_course/detail_item.dart';
import 'package:flutter_course/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Initialize an empty cartItems list
  List<Map<String, dynamic>> cartItems = [];

  void _onTap(int index) {
    if (index == 1) {
      // Navigate to Cart
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CartPage(cartItems: cartItems), // Pass cartItems to CartPage
        ),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountPage(cartItems: cartItems),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // 🔷 Dynamic categories
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.laptop, 'label': 'Laptop'},
    {'icon': Icons.phone_android_rounded, 'label': 'Phone'},
    {'icon': Icons.tv, 'label': 'TV'},
    {'icon': Icons.electric_bike_outlined, 'label': 'E-bike'},
    {'icon': Icons.car_crash, 'label': 'Car'},
  ];

  late Future<List<dynamic>>? topProducts;

  @override
  void initState() {
    super.initState();
    topProducts = Products.fetchProducts().then(
      (products) => products.take(3).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _buildAppBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.blue,
        onTap: _onTap, // Add this line to handle navigation
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: "Cart"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "Account",
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 🔍 Search Bar
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.blue[500],
                      hintText: "Search",
                      hintStyle: const TextStyle(fontSize: 20),
                      border: InputBorder.none,
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.menu, size: 35),
              ],
            ),

            const SizedBox(height: 20),

            // 🗂 Categories Section
            const Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategory(category['icon'], category['label']);
                },
              ),
            ),

            const SizedBox(height: 20),
            Container(
              child: Center(
                child: Container(
                  child: MaterialButton(
                    color: Colors.grey[300],
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Products()),
                      );
                    },
                    child: Text('all our products'),
                  ),
                ),
              ),
            ),

            // 💰 Best Selling Section
            // 💰 Best Selling Section
            const Text(
              "Best Selling",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            FutureBuilder<List<dynamic>>(
              future: topProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailItem(
                                  data: item,
                                  cartItems: cartItems,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: _buildSelling(
                            item['image'],
                            item['title'],
                            item['category'], // or 'description' if you prefer
                            (item['price'] as num).toInt(),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No products found"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Mody Shop"),
      leading: Image.asset("images/logo.png"),
    );
  }

  // 🔧 Category Card Widget
  Widget _buildCategory(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🛍 Selling Item Card Widget
  Widget _buildSelling(
    String imgPath,
    String title,
    String subtitle,
    int price,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imgPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '\$${price.toString()}',
            style: TextStyle(
              fontSize: 19,
              color: Colors.amber[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
