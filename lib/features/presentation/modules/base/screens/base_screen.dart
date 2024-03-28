import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Screen'),
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
