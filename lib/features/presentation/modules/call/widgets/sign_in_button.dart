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
      width: 200,
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
        child: const Text('Sign In', style: buttonTextStyle),
      ),
    );
  }
}
