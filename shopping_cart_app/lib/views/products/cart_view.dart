import 'package:flutter/material.dart';
import 'package:shopping_cart_app/views/products/product_detail_view.dart';
import '../../service/api/cart_service.dart';

class CartView extends StatefulWidget {
  final String email;
  const CartView({required this.email, super.key});

  @override
  State<StatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<dynamic>> _cartProductsFuture;
  double totalValue = 0;

  @override
  void initState() {
    super.initState();
    _cartProductsFuture = CartService.getCartProducts(widget.email);
    calculateTotalValue();
    CartService.quantityStream.listen((_) {
      refreshCartProducts();
    });
  }

  void calculateTotalValue() async {
    final cartProducts = await _cartProductsFuture;
    setState(() {
      totalValue = cartProducts.fold(0, (previous, product) {
        final quantity = product['quantity'];
        final price = product['productInfo']['price'];
        return previous + (quantity * price);
      });
    });
  }

  void refreshCartProducts() async {
    setState(() {
      _cartProductsFuture = CartService.getCartProducts(widget.email);
    });
    calculateTotalValue();
  }

  Widget buildProductTile(dynamic product, int quantity) {
    return ListTile(
      onTap: () async {
        final removed = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(
              productId: product['productId'],
              email: widget.email,
            ),
          ),
        );
        if (removed != null && removed) {
          refreshCartProducts();
        }
      },
      leading: SizedBox(
        width: 120,
        height: 120,
        child: Image.network(product['thumbnail']),
      ),
      title: Text(product['title']),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Price: \$${product['price']} '),
          StreamBuilder<Map<String, int>>(
            stream: CartService.quantityStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final updatedQuantities = snapshot.data!;
                final updatedQuantity =
                    updatedQuantities[product['productId']] ?? quantity;
                return Text('Quantity: $updatedQuantity');
              } else {
                return Text('Quantity: $quantity');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8),
      child: Text("Total is \$$totalValue"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _cartProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<dynamic> cartProducts = snapshot.data!;

            if (cartProducts.isEmpty) {
              return const Center(child: Text('Cart is empty'));
            }

            return ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index]['productInfo'];
                final quantity = cartProducts[index]['quantity'];
                return buildProductTile(product, quantity);
              },
            );
          }
        },
      ),
      bottomSheet: buildBottomSheet(),
    );
  }
}
