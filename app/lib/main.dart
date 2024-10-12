// simple flutter store app with dark theme toggle
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

// Product model
void main() {
  runApp(MyApp());
}

// Main app widget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Main app state
class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  // List of products
  List<Product> products = [
    Product(
        name: 'Product 1', imageUrl: 'assets/images/product1.jpg', price: 10.0),
    Product(
        name: 'Product 2', imageUrl: 'assets/images/product2.jpg', price: 20.0),
    Product(
        name: 'Product 3', imageUrl: 'assets/images/product3.jpg', price: 30.0),
    Product(
        name: 'Product 4', imageUrl: 'assets/images/product4.jpg', price: 40.0),
  ];

  // Build the app
  @override
  Widget build(BuildContext context) {
    // Return the app
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      // Set the theme based on the isDarkTheme flag
      theme: isDarkTheme ? MyTheme.darkTheme : MyTheme.lightTheme,
      // Home page
      home: CatalogPage(
        products: products,
        // Pass the onThemeToggle callback to the CatalogPage
        onThemeToggle: () {
          // Toggle the theme
          setState(() {
            // Set the isDarkTheme flag to the opposite value
            isDarkTheme = !isDarkTheme;
          });
        },
      ),
    );
  }
}

// Catalog page
class CatalogPage extends StatelessWidget {
  // List of products
  final List<Product> products;
  // Theme toggle callback
  final VoidCallback onThemeToggle;

  // Constructor
  CatalogPage({required this.products, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'),
        actions: [
          IconButton(
            // Theme toggle button
            icon: Icon(Icons.brightness_3_rounded),
            // Call the onThemeToggle callback when the button is pressed
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: GridView.builder(
        // Grid view
        gridDelegate:
            // 2 columns
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

// Product card
class ProductCard extends StatefulWidget {
  final Product product;

  // Constructor
  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

// Product card state
class _ProductCardState extends State<ProductCard> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delay the animation to simulate fade-in
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Show product details when the card is tapped
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(widget.product.name),
            content: Text('Price: \$${widget.product.price.toString()}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      // Product card
      child: Card(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 1), // Fade-in animation duration
              child:
                  Image.asset(widget.product.imageUrl, height: 150, width: 150),
            ),
            Text(widget.product.name),
            Text('\$${widget.product.price.toString()}'),
          ],
        ),
      ),
    );
  }
}
