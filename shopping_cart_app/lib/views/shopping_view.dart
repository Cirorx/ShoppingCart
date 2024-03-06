import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../service/api/product_service.dart';
import 'product_detail_view.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ProductService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Product> products = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Shopping List'),
            ),
            body: GridView.count(
              crossAxisCount: 2,
              children: List.generate(products.length, (index) {
                return GestureDetector(
                  onTap: () {
                    // Navegar a la vista de detalles del producto
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: products[index])),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(products[index].thumbnail),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    //TODO: cart implementation
                                  },
                                ),
                                Text('Precio: \$${products[index].price}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    //TODO: cart implementation
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
