// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_course/detail_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 🔷 Dynamic categories
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.laptop, 'label': 'Laptop'},
    {'icon': Icons.phone_android_rounded, 'label': 'Phone'},
    {'icon': Icons.tv, 'label': 'TV'},
    {'icon': Icons.electric_bike_outlined, 'label': 'E-bike'},
    {'icon': Icons.car_crash, 'label': 'Car'},
  ];

  // 🔶 Dynamic selling items
  final List<Map<String, dynamic>> sellingItems = [
    {
      'image': 'images/headphone.jpg',
      'title': 'Headphone',
      'subtitle': 'High quality',
      'price': 12,
    },
    {
      'image': 'images/laptop.jpg',
      'title': 'Laptop',
      'subtitle': 'Fast and sleek',
      'price': 80,
    },
    {
      'image': 'images/tv.jpg',
      'title': 'TV',
      'subtitle': 'Smart 4K UHD',
      'price': 50,
    },
    {
      'image': 'images/phone.jpg',
      'title': 'Phone',
      'subtitle': 'Latest model',
      'price': 300,
    },
    {
      'image': 'images/bike.jpg',
      'title': 'Bike',
      'subtitle': 'Mountain bike',
      'price': 120,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mody Shop"),
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shop",
          ),
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

            // 💰 Best Selling Section
            const Text(
              "Best Selling",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 🛒 Product Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sellingItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = sellingItems[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Detail_item(data: item),
                        ),
                      );
                      // TODO: Add navigation or action here
                      print('Tapped on ${item['title']}');
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: _buildSelling(
                      item['image'],
                      item['title'],
                      item['subtitle'],
                      item['price'],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
                image: AssetImage(imgPath),
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
