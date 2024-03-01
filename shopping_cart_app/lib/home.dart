import 'package:flutter/material.dart';
import 'package:shopping_cart_app/views/product_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCarousel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showCarousel = true;
                });
              },
              child: const Text('Load Products'),
            ),
            if (_showCarousel) const ProductCarousel(),
          ],
        ),
      ),
    );
  }
}
