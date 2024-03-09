import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../service/api/cart_service.dart';

class CartView extends StatelessWidget {
  final String email;

  const CartView({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: CartService.getCartProducts(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Product> products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index].title),
                subtitle: Text('Price: \$${products[index].price}'),
              );
            },
          );
        }
      },
    );
  }
}
