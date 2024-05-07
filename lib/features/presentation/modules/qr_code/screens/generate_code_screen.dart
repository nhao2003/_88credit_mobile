import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../bloc/qr_code_bloc.dart';

class GenerateCodeScreen extends StatefulWidget {
  const GenerateCodeScreen({super.key});

  @override
  State<GenerateCodeScreen> createState() => _GenerateCodeScreenState();
}

class _GenerateCodeScreenState extends State<GenerateCodeScreen> {
  @override
  void initState() {
    context.read<QrCodeBloc>().add(const GetUserId());
    super.initState();
  }

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
                  if (state.userID.isNotEmpty)
                    QrImageView(
                      data: "user_id:${state.userID}",
                      size: 280,
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size(
                          100,
                          100,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
