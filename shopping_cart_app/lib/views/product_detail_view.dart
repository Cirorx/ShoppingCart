import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../utils/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(product.thumbnail),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  infoWidget('Description:', '${product.description}\n'),
                  infoWidget('Price: \$${product.price}', ''),
                  infoWidget('Stock: ${product.stock}', ''),
                  infoWidget('Brand: ${product.brand}', ''),
                  infoWidget('Category: ${product.category.toUpperCase()}', ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
