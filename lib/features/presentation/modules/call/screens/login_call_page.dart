import 'package:flutter/material.dart';

import '../widgets/log_in_app_bar.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/text_field_widget.dart';

class LoginCallScreen extends StatefulWidget {
  const LoginCallScreen({super.key});

  @override
  State<LoginCallScreen> createState() => _LogInPageState();
}

class _LogInPageState extends State<LoginCallScreen> {
  final TextEditingController phoneNum = TextEditingController();
  final TextEditingController password = TextEditingController();

  //dispose the controller to release the memory
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNum.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const LogInAppBar()),
      backgroundColor: Colors.blueGrey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFieldWidget(
                controller: phoneNum,
                hintText: 'Phone',
                icon: const Icon(Icons.phone)),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                controller: password,
                hintText: 'Password',
                icon: const Icon(Icons.lock_open)),
            const SizedBox(
              height: 30,
            ),
            SignInButton(
              userID: phoneNum,
            )
          ],
        ),
      ),
    );
  }
}
