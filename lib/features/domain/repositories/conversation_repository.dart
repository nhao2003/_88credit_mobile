import 'package:_88credit_mobile/features/domain/entities/chat/conversation.dart';
import 'package:_88credit_mobile/features/domain/entities/chat/message.dart';

abstract class ConversationRepository {
  // void addConversationListener(Function(List<ConversationEntitiy>) listener);
  // void removeConversationListener(Function(List<ConversationEntitiy>) listener);
  // List<ConversationEntitiy> getConversations();
  // void addMessageListener(
  //     String conversationId, Function(List<MessageEntity>) listener);
  // void removeMessageListener(
  //     String conversationId, Function(List<MessageEntity>) listener);
  // List<MessageEntity>? initChat(String conversationId);
  // void sendTextMessage(String conversationId, String message);
  // void connect();
  // void disconnect();
  Future<List<ConversationEntitiy>> getAllConversations();
  Future<List<MessageEntity>> getMessages(String conversationId);
}
