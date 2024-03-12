import 'package:flutter/material.dart';
import 'package:shopping_cart_app/views/products/product_detail_view.dart';
import '../../service/api/cart_service.dart';

class CartView extends StatelessWidget {
  final String email;

  const CartView({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: CartService.getCartProducts(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> cartProducts = snapshot.data!;
          double totalValue = 0;
          if (cartProducts.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              final product = cartProducts[index]['productInfo'];
              final quantity = cartProducts[index]['quantity'];

              totalValue += product['price'] * quantity;
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailView(
                        productId: product['productId'],
                        email: email,
                      ),
                    ),
                  );
                },
                leading: Container(
                  width: 90,
                  height: 90,
                  child: Image.network(product['thumbnail']),
                ),
                title: Text(product['title']),
                subtitle: Text('Price: \$${product['price']}'),
              );
            },
          );
        }
      },
    );
  }
}
