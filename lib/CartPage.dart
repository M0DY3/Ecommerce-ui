import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: widget.cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return cartItemTile(item, index);
              },
            ),
    );
  }

  // Function to display a cart item with delete button
  Widget cartItemTile(Map<String, dynamic> item, int index) {
    return ListTile(
      leading: Image.network(
        item['image'],
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.broken_image, size: 50, color: Colors.grey);
        },
      ),
      title: Text(item['title']),
      subtitle: Text(
        'Size: ${item['size']} | Color: ${item['color']} | \$${item['price']}',
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          setState(() {
            widget.cartItems.removeAt(index);
          });
        },
      ),
    );
  }
}
