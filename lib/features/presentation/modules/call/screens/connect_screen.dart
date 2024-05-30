import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/call_bloc.dart';
import '../widgets/button_style.dart';
import '../widgets/text_field_widget.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final callID = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    callID.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: const MyAppbar(title: "Call Video"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Your Phone Number: ${state.currentUser.id}'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Enter Phone Number',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 10,
              ),
              joinCallContainer()
            ],
          ),
        );
      },
    );
  }

  Widget joinCallContainer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextFieldWidget(
                controller: callID,
                hintText: 'join call by id',
                //no icon
                icon: const SizedBox()),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100.wp,
              child: ElevatedButton(
                  onPressed: () async {
                    if (callID.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(child: Text('Please input unique ID')),
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      context
                          .read<CallBloc>()
                          .add(ChangeCallID(callID: callID.text));
                      // await 1s for change callID
                      await Future.delayed(const Duration(seconds: 1));
                      if (!mounted) return;
                      Navigator.pushNamed(context, AppRoutes.callVideo);
                    }
                  },
                  style: buttonStyle,
                  child: Text('Call Now', style: buttonTextStyle)),
            )
          ],
        ),
      ),
    );
  }
}
