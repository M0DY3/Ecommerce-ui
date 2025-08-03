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
                return printItemCart(item, index);
              },
            ),
    );
  }

  // Function to print a cart item and provide a delete button
  Widget printItemCart(Map<String, dynamic> item, int index) {
    return ListTile(
      leading: Image.asset("${item['image']}"),
      title: Text(item['title']),
      subtitle: Text(
        'Size: ${item['size']} | Color: ${item['color']} | \$${item['price']} ${index}',
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
