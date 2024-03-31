import 'package:flutter/material.dart';
import '../widgets/image_not_found.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Screen'),
      ),
      body: const ImageNotFound(),
    );
  }
}
