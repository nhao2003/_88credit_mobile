import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatelessWidget {
  const ScanCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          // for (final barcode in barcodes) {
          //   print("Barcode found: ${barcode.rawValue}");
          // }
          if (barcodes.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(barcodes.first.rawValue ?? "No barcode found"),
              ),
            );
          }
          if (image != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(barcodes.first.rawValue ?? "No barcode found"),
                content: Image.memory(image),
              ),
            );
          }
        },
      ),
    );
  }
}
