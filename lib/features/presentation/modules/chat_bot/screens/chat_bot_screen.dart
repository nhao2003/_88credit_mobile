import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final _openAI = OpenAI.instance.build(
    token: dotenv.env['GPT_API_KEY'],
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 10),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: "Minh",
    lastName: "Phan",
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: "Chat",
    lastName: "GPT",
  );

  final List<ChatMessage> _messages = [];
  final List<ChatUser> _typingUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: 'Chat với AI',
      ),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        messageOptions: const MessageOptions(
          currentUserContainerColor: AppColors.green,
          containerColor: AppColors.green100,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage message) async {
    try {
      setState(() {
        _messages.insert(0, message);
        _typingUsers.add(_gptChatUser);
      });

      List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
        if (m.user == _currentUser) {
          return Messages(role: Role.user, content: m.text).toJson();
        } else {
          return Messages(role: Role.assistant, content: m.text).toJson();
        }
      }).toList();

      final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: messagesHistory,
        maxToken: 200,
      );

      final response = await _openAI.onChatCompletion(request: request);
      for (final element in response!.choices) {
        if (element.message != null) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                user: _gptChatUser,
                text: element.message!.content,
                createdAt: DateTime.now(),
              ),
            );
          });
        }
      }

      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
    } catch (e) {
      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
      if (!mounted) return;
      context.snackBar(
        e.toString(),
        type: AnimatedSnackBarType.error,
      );
    }
  }
}
