import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/api/product_service.dart';
import '../model/product_model.dart';
import '../service/api/cart_service.dart';
import '../utils/widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final String email;
  final String productId;

  const ProductDetailScreen(
      {Key? key, required this.productId, required this.email})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _productFuture;
  late int _stock;
  @override
  void initState() {
    super.initState();
    _productFuture = ProductService.getProductById(widget.productId);

    ProductService.getInitialStock(widget.productId);
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
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(product.images[index]);
                        },
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        infoWidget('Description: \n ${product.description}\n'),
                        infoWidget('Price: \$${product.price}'),
                        StreamBuilder<int>(
                          stream: ProductService.stockStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final stock = snapshot.data!;
                              _stock = stock;
                              return infoWidget('Stock: $_stock');
                            } else {
                              return infoWidget('Stock: Loading...');
                            }
                          },
                        ),
                        infoWidget('Brand: ${product.brand}'),
                        infoWidget('Category: ${product.category}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            infoWidget(
                              'Add to cart',
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                CartService.modifyCart(
                                  widget.email,
                                  product.id,
                                  1,
                                );
                              },
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                CartService.modifyCart(
                                  widget.email,
                                  product.id,
                                  -1,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
