import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Base2Screen extends StatelessWidget {
  const Base2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Screen 2'),
      ),
      body: ElevatedButton(
        onPressed: () => context.pop(),
        child: const Text("Go to Settings page"),
      ),
    );
  }
}
