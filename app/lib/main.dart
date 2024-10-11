import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  List<Product> products = [
    Product(name: 'Product 1', imageUrl: 'assets/', price: 10.0),
    Product(name: 'Product 2', imageUrl: 'assets/product_2.jpg', price: 20.0),
    Product(name: 'Product 3', imageUrl: 'assets/product_3.jpg', price: 30.0),
    Product(name: 'Product 4', imageUrl: 'assets/product_4.jpg', price: 40.0),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      theme: isDarkTheme ? MyTheme.darkTheme : MyTheme.lightTheme,
      home: CatalogPage(
        products: products,
        onThemeToggle: () {
          setState(() {
            isDarkTheme = !isDarkTheme;
          });
        },
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onThemeToggle;

  CatalogPage({required this.products, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(products[index].name),
                  content: Text('Price: \$${products[index].price.toString()}'),
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
            child: Card(
              child: Column(
                children: [
                  Image.network(products[index].imageUrl,
                      height: 100, width: 100),
                  Text(products[index].name),
                  Text('\$${products[index].price.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
