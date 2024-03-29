import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Screen 1'),
      ),
      body: ElevatedButton(
        onPressed: () => context.push("/base2"),
        child: const Text("Go to Settings page"),
      ),
    );
  }
}
