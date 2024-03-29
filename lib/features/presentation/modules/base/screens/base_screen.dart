import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Screen 1'),
      ),
      body: ElevatedButton(
        onPressed: () {},
        child: const Text("Go to Settings page"),
      ),
    );
  }
}
