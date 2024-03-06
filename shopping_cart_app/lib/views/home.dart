import 'package:flutter/material.dart';
import 'package:shopping_cart_app/views/shopping_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO implement: Categorized view, All products view (shopping list), Cart view and cart logic, Log Out

    return ShoppingList();
  }
}
