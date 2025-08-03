import 'package:flutter/material.dart';
import 'CartPage.dart';

class DetailItem extends StatefulWidget {
  // Receive data and cartItems from HomePage
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> cartItems; // This will hold the cart items

  const DetailItem({
    Key? key,
    required this.data, // Passing product data
    required this.cartItems, // Passing cart items from HomePage
  }) : super(key: key);

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  int num = 20; // A placeholder, you might not need this
  int? selectedSize; // Holds selected size for product
  Color? selectedColor; // Holds selected color for product

  @override
  Widget build(BuildContext context) {
    final data = widget.data; // Accessing product data passed from HomePage

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Mody Shop", // Title of the app bar
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
            // 🖼 Product Image Section
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(data['image']), // Load product image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 📄 Title, Subtitle, and Price
            Text(
              data['title'], // Product title
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              data['subtitle'], // Product subtitle
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${data['price']}", // Product price
              style: TextStyle(fontSize: 22, color: Colors.amber[700]),
            ),

            // 🎨 Color Options Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Color : "),
                SizedBox(width: 10),
                // GestureDetector for color selection
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = Colors.grey; // Set selected color to grey
                    });
                    print('Selected Color: Gray');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey, // Grey color option
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selectedColor == Colors.grey
                              ? Colors
                                    .blue // Apply blue border if selected
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // GestureDetector for black color selection
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor =
                          Colors.black; // Set selected color to black
                    });
                    print('Selected Color: Black');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.black, // Black color option
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selectedColor == Colors.black
                              ? Colors
                                    .blue // Apply blue border if selected
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 🧳 Size Selection Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Size : "),
                // Loop to display size options
                for (int i = 25; i < 30; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = i; // Update the selected size
                        });
                        print('Tapped on $i');
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue, // Color of the size options
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedSize == i
                                ? Colors
                                      .orange // Apply orange border if size is selected
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '$i', // Display size number
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

            // 🛒 Add to Cart Button
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {
                  // Check if both color and size are selected
                  if (selectedColor == null || selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select both color and size!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Do not proceed if either is not selected
                  }

                  // Add the selected item to the cart
                  widget.cartItems.add({
                    'image': widget.data['image'], // Add image of selected item
                    'title': widget.data['title'], // Add title
                    'subtitle': widget.data['subtitle'], // Add subtitle
                    'price': widget.data['price'], // Add price
                    'size': selectedSize, // Add size
                    'color': selectedColor == Colors.grey
                        ? "Gray"
                        : "Black", // Add color
                  });

                  // Navigate to the CartPage with updated cart
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
}
