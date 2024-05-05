import 'dart:typed_data';
import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatelessWidget {
  const ScanCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: 'Quét mã QR'),
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
