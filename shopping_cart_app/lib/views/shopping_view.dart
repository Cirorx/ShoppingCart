import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/product_model.dart';
import '../service/api/cart_service.dart';
import '../service/api/product_service.dart';
import 'product_detail_view.dart';

class ShoppingList extends StatefulWidget {
  final String email;

  const ShoppingList({required this.email, super.key});
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Future<List<Product>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Product> products = snapshot.data!;

          return Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              children: List.generate(products.length, (index) {
                return GestureDetector(
                  onTap: () {
                    // go to product details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: products[index])),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: <Widget>[
                              Image.network(products[index].thumbnail),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        const Color.fromARGB(255, 255, 255, 255)
                                            .withOpacity(0.8),
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          CartService.modifyCart(
                                            widget.email,
                                            products[index].id,
                                            -1,
                                          );
                                        },
                                      ),
                                      Text(
                                        'Precio: \$${products[index].price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          CartService.modifyCart(
                                            widget.email,
                                            products[index].id,
                                            1,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
