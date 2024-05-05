import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(
        title: 'Chat với AI',
      ),
      body: Center(
        child: Text('Chat Bot Screen'),
      ),
    );
  }
}
