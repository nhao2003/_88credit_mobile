part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ConversationModel> conversations;
  final List<MessageModel> messages;
  final String conversationId;

  const ChatState({
    this.conversations = const [],
    this.messages = const [],
    this.conversationId = '',
  });

  ChatState copyWith({
    List<ConversationModel>? conversations,
    List<MessageModel>? messages,
    String? conversationId,
  }) {
    return ChatState(
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
    );
  }

  @override
  List<Object> get props => [
        conversations,
        messages,
        conversationId,
      ];
}
