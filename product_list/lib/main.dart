import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ProductApp());
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

List<Product> products = [
  Product(
      name: 'Laptop',
      price: 1500,
      imageUrl:
          'https://productimages.hepsiburada.net/s/513/222-222/110000568470493.jpg/format:webp'),
  Product(
      name: 'Telefon',
      price: 800,
      imageUrl:
          'https://productimages.hepsiburada.net/s/777/222-222/110000755421753.jpg/format:webp'),
  Product(
      name: 'Tablet',
      price: 500,
      imageUrl:
          'https://productimages.hepsiburada.net/s/487/222-222/110000534697383.jpg/format:webp'),
  Product(
      name: 'Kulaklık',
      price: 100,
      imageUrl:
          'https://productimages.hepsiburada.net/s/404/222-222/110000429711422.jpg/format:webp'),
  Product(
      name: 'Akıllı Saat',
      price: 200,
      imageUrl:
          'https://productimages.hepsiburada.net/s/136/222-222/110000088697373.jpg/format:webp'),
  Product(
      name: 'Sırt Çantası',
      price: 40,
      imageUrl:
          'https://productimages.hepsiburada.net/s/325/222-222/110000319735658.jpg/format:webp'),
  Product(
      name: 'Oyun Konsolu',
      price: 300,
      imageUrl:
          'https://productimages.hepsiburada.net/s/369/222-222/110000386763612.jpg/format:webp'),
  Product(
      name: 'VR Gözlüğü',
      price: 400,
      imageUrl:
          'https://productimages.hepsiburada.net/s/95/222-222/110000038547194.jpg/format:webp'),
];

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ürün Listesi',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color.fromARGB(255, 55, 112, 17)),
      ),
      home: ProductScreen(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color,
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Listesi'),
      ),
      body: Column(
        children: [
          _buildHorizontalListView(),
          Expanded(child: _buildGridView()),
        ],
      ),
    );
  }

  Widget _buildHorizontalListView() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Color.fromARGB(255, 81, 159, 80)
                    : Color.fromARGB(255, 131, 188, 146),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  products[index].name,
                  style: TextStyle(
                    color: selectedIndex == index
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Colors.orange[200]
                  : Colors.grey[200],
              border: Border.all(
                color: selectedIndex == index
                    ? Color.fromARGB(255, 100, 135, 141)
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  products[index].imageUrl,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                Text(
                  products[index].name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '₺${NumberFormat('#,##0.00', 'en_US').format(products[index].price)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
