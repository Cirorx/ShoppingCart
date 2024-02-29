import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Create'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Read'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
