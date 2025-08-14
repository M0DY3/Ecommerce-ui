import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();

  // 🔹 Static helper to fetch products
  static Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        leading: Icon(Icons.shopping_bag),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Products.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      product['image'],
                      height: 50,
                      width: 50,
                    ),
                    title: Text(product['title']),
                    subtitle: Text("\$${product['price']}"),
                  ),
                );
              },
            );
          }
          return Center(child: Text("No products found"));
        },
      ),
    );
  }
}
