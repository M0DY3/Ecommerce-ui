import 'package:flutter/material.dart';
import 'package:flutter_course/CartPage.dart';

class AccountPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const AccountPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<AccountPage> createState() => AccountState();
}

class AccountState extends State<AccountPage> {
  late int cartCount;
  @override
  void initState() {
    super.initState();
    cartCount = widget.cartItems.length; // Initialize here
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account'), leading: Icon(Icons.account_box)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 150,
              child: Card(
                color: Colors.blueGrey[200],
                child: ListTile(
                  leading: Image.asset("images/33.jpg", fit: BoxFit.cover),
                  title: Text(
                    "Mody",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    "mody@mody.com",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Text(
                    "2002/2/2",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: widget.cartItems),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Items in Cart'),
                  trailing: Text(
                    cartCount.toString(),
                  ), // Use a variable if dynamic
                ),
              ),
            ),
            Center(
              child: Container(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(
                      context,
                    ); // Goes back to previous screen (home)
                  },
                  child: Text('Back to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
