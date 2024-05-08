import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/features/presentation/globalwidgets/my_appbar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  // final _openAI = OpenAI.instance.build(
  //   token: dotenv.env['GPT_API_KEY'],
  //   baseOption: HttpSetup(
  //     receiveTimeout: const Duration(seconds: 10),
  //   ),
  //   enableLog: true,
  // );

  final _gemini = GenerativeModel(
    model: 'gemini-pro',
    apiKey: dotenv.env['GEMINI_API_KEY']!,
  );

  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: "Minh",
    lastName: "Phan",
  );

  final ChatUser _geminiChatUser = ChatUser(
    id: '2',
    firstName: "Chat",
    lastName: "Gemini",
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
        _typingUsers.add(_geminiChatUser);
      });

      // List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
      //   if (m.user == _currentUser) {
      //     return Message(isUser: true, message: m.text).toJson();
      //   } else {
      //     return Message(role: Role.assistant, content: m.text).toJson();
      //   }
      // }).toList();

      final content = [Content.text(message.text)];
      final response = await _gemini.generateContent(content);
      setState(() {
        // Add bot's response to the chat
        setState(() {
          if (response.text != null) {
            _messages.insert(
              0,
              ChatMessage(
                user: _geminiChatUser,
                text: response.text!,
                createdAt: DateTime.now(),
              ),
            );
          }
        });
      });

      // final request = ChatCompleteText(
      //   model: GptTurbo0301ChatModel(),
      //   messages: messagesHistory,
      //   maxToken: 200,
      // );

      // final response = await _openAI.onChatCompletion(request: request);
      // for (final element in response!.choices) {
      //   if (element.message != null) {
      //     setState(() {
      //       _messages.insert(
      //         0,
      //         ChatMessage(
      //           user: _geminiChatUser,
      //           text: element.message!.content,
      //           createdAt: DateTime.now(),
      //         ),
      //       );
      //     });
      //   }
      // }

      setState(() {
        _typingUsers.remove(_geminiChatUser);
      });
    } catch (e) {
      setState(() {
        _typingUsers.remove(_geminiChatUser);
      });
      if (!mounted) return;
      context.snackBar(
        e.toString(),
        type: SnackBarType.error,
      );
    }
  }
}

class Message {
  final bool isUser;
  final String message;
  late DateTime? date;

  Message({
    required this.isUser,
    required this.message,
    this.date,
  }) {
    date ??= DateTime.now();
  }
}
