import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../bloc/qr_code_bloc.dart';

class GenerateCodeScreen extends StatelessWidget {
  const GenerateCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: 'Tạo mã QR'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<QrCodeBloc, QrCodeState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter data to encode',
                    ),
                    onSubmitted: (value) {
                      context.read<QrCodeBloc>().add(GenerateQrCode(value));
                    },
                  ),
                  const SizedBox(height: 20),
                  if (state.qrData.isNotEmpty)
                    PrettyQrView.data(data: state.qrData),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
