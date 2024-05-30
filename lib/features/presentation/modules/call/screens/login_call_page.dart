import 'package:flutter/material.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/text_field_widget.dart';

class LoginCallScreen extends StatefulWidget {
  const LoginCallScreen({super.key});

  @override
  State<LoginCallScreen> createState() => _LogInPageState();
}

class _LogInPageState extends State<LoginCallScreen> {
  final TextEditingController phoneNum = TextEditingController();

  //dispose the controller to release the memory
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNum.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: 'Create User',
      ),
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
                hintText: 'UserID',
                icon: const Icon(Icons.person)),
            const SizedBox(
              height: 20,
            ),
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
