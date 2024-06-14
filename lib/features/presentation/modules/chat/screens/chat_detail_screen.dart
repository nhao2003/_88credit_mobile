import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/domain/entities/chat/message.dart';
import 'package:_88credit_mobile/features/domain/usecases/authentication/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../di/injection_container.dart';
import '../../../../data/models/chat/message_model.dart';
import '../../../../domain/entities/chat/conversation.dart';
import '../../../../domain/repositories/conversation_repository.dart';
import '../../../globalwidgets/my_appbar.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final ConversationEntitiy conversation;
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;
  bool isShowButtons = true;
  late String? userId;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _updateShowButtons();
    });
    _textEditingController = TextEditingController();
    getUserId();
    // initMessage(conversation.id);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
    // disposeMessage();
  }

  // get messages
  Future<List<MessageEntity>> getMessages(String id) async {
    ConversationRepository conversationRepository =
        sl<ConversationRepository>();
    final conversations = await conversationRepository.getMessages(id);
    // return controller.conversations;
    return conversations;
  }

  Future<void> getUserId() async {
    GetUserIdUseCase getUserIdUseCase = sl<GetUserIdUseCase>();
    userId = await getUserIdUseCase();
  }

  @override
  Widget build(BuildContext context) {
    conversation =
        ModalRoute.of(context)!.settings.arguments as ConversationEntitiy;

    return Scaffold(
      appBar: const MyAppbar(
        title: 'Nguyễn Nhật Hào', // Replace with the participant's name
      ),
      body: FutureBuilder<List<MessageEntity>>(
          future: getMessages(conversation.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<MessageEntity> messages = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      MessageEntity message = messages[index];
                      bool isMe = message.senderId == userId;
                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isMe ? AppColors.green800 : AppColors.grey100,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(message.content['text'] ?? "Null",
                                style: AppTextStyles.regular16.colorEx(
                                  isMe ? AppColors.white : AppColors.black,
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                _buildMessageInput(),
              ],
            );
          }),
    );
  }

  bool _updateShowButtons() {
    bool val = !_focusNode.hasFocus || _textEditingController.text.isEmpty;
    if (isShowButtons != val) {
      setState(() {
        isShowButtons = val;
      });
    }
    return val;
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Visibility(
            visible: isShowButtons,
            child: IconButton(
              icon: const Icon(
                HeroiconsSolid.photo,
                color: AppColors.green,
              ),
              onPressed: () {
                // Implement the logic to handle image
              },
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: 6,
              minLines: 1,
              controller: _textEditingController,
              onChanged: (value) {
                _updateShowButtons();
              },
              focusNode: _focusNode,
              onTapOutside: (event) => _focusNode.unfocus(),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                hintText: 'Tin nhắn',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              HeroiconsSolid.paperAirplane,
              color: AppColors.green,
            ),
            onPressed: () {
              // sendMessage(_textEditingController.text.trim().toString());
            },
          ),
        ],
      ),
    );
  }
}
