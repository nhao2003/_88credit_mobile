import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../bloc/call_bloc.dart';

class CallVideoPage extends StatefulWidget {
  const CallVideoPage({super.key});

  @override
  State<CallVideoPage> createState() => _CallVideoPageState();
}

class _CallVideoPageState extends State<CallVideoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        return SafeArea(
          child: ZegoUIKitPrebuiltCall(
            appID: int.tryParse(dotenv.env['APP_ID']!)!,
            appSign: dotenv.env['APP_SIGN']!,
            callID: state.callID,
            userID: state.currentUser.id,
            userName: state.currentUser.name,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          ),
        );
      },
    );
  }
}
