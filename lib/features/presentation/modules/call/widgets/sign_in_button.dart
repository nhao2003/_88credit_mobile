import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/features/presentation/modules/call/bloc/call_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/connect_screen.dart';
import 'button_style.dart';

class SignInButton extends StatelessWidget {
  final TextEditingController userID;
  const SignInButton({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.wp,
      child: ElevatedButton(
        onPressed: () {
          context.read<CallBloc>().add(
                ChangeUser(
                  id: userID.text.trim(),
                  name: 'user_${userID.text}',
                ),
              );
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ConnectScreen()));
        },
        style: buttonStyle,
        child: Text(
          'Đăng nhập',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
