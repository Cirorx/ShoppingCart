class Cart {
  final String userId;
  //item = product, but it isn't a linked class just a reference one
  final List<CartItem> items;

  Cart({
    required this.userId,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      userId: json['userId'],
      items: List<CartItem>.from(
          json['items'].map((item) => CartItem.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  final String productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
