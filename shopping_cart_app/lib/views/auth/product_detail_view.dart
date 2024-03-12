import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/api/product_service.dart';
import '../../model/product_model.dart';
import '../../service/api/cart_service.dart';
import '../../utils/widgets.dart';

class ProductDetailView extends StatefulWidget {
  final String email;
  final String productId;

  const ProductDetailView(
      {super.key, required this.productId, required this.email});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductService.getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Product>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(snapshot.data!.title);
              }
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final product = snapshot.data!;
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: 'product-${product.id}',
                          child: Image.network(product.images[index]),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        infoWidget('Description: ${product.description}'),
                        infoWidget('Price: \$${product.price}'),
                        StreamBuilder<int>(
                          stream: ProductService.stockStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final stock = snapshot.data!;
                              return infoWidget('Stock: $stock');
                            } else {
                              return infoWidget('Stock: ${product.stock}');
                            }
                          },
                        ),
                        infoWidget('Brand: ${product.brand}'),
                        infoWidget('Category: ${product.category}'),
                        const SizedBox.square(
                          dimension: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () async {
                                await CartService.modifyCart(
                                  widget.email,
                                  product.id,
                                  1,
                                );
                                showToast(
                                    "${product.title} was added to your cart.");
                              },
                              style: getButtonStyle(),
                              child: const Text('Add to cart'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await CartService.modifyCart(
                                  widget.email,
                                  product.id,
                                  -1,
                                );
                                showToast(
                                  "${product.title} was removed from your cart.",
                                );
                              },
                              style: getButtonStyle(),
                              child: const Text('Remove from cart'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
