import 'package:flutter/material.dart';
import 'CartPage.dart';

class DetailItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> cartItems;

  const DetailItem({Key? key, required this.data, required this.cartItems})
    : super(key: key);

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  int? selectedSize;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Mody Shop",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  data['image'],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Title, Subtitle, Price
            Text(
              data['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              data['subtitle'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              "\$${data['price']}",
              style: TextStyle(fontSize: 22, color: Colors.amber[700]),
            ),

            SizedBox(height: 10),

            // Color selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Color: "),
                SizedBox(width: 10),
                _colorOption(Colors.grey),
                SizedBox(width: 10),
                _colorOption(Colors.black),
              ],
            ),

            SizedBox(height: 10),

            // Size selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Size: "),
                for (int i = 25; i < 30; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = i;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedSize == i
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 10),

            // Add to cart button
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (selectedColor == null || selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select both color and size!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  widget.cartItems.add({
                    'image': data['image'],
                    'title': data['title'],
                    'subtitle': data['subtitle'],
                    'price': data['price'],
                    'size': selectedSize,
                    'color': selectedColor == Colors.grey ? "Gray" : "Black",
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CartPage(cartItems: widget.cartItems),
                    ),
                  );
                },
                color: Colors.lightBlueAccent[50],
                child: Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color selection widget
  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selectedColor == color ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
