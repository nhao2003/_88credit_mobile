import 'package:_88credit_mobile/features/domain/entities/chat/conversation.dart';
import 'package:_88credit_mobile/features/domain/entities/chat/message.dart';

import '../../domain/repositories/conversation_repository.dart';
import '../datasources/local/authentication_local_data_source.dart';
import '../datasources/remote/conversation_remote_data_source.dart';
import '../models/chat/conversation_model.dart';

class ConversationRepositoryImpl extends ConversationRepository {
  final ConversationRemoteDataSource _conversationRemoteDataSource;

  ConversationRepositoryImpl(this._conversationRemoteDataSource);

  @override
  Future<List<ConversationEntitiy>> getAllConversations() {
    print('getAllConversations');
    return _conversationRemoteDataSource.getAllConversations();
  }

  @override
  Future<List<MessageEntity>> getMessages(String conversationId) {
    return _conversationRemoteDataSource.getMessages(conversationId);
  }

  // @override
  // void addConversationListener(Function(List<ConversationModel> p1) listener) {
  //   _conversationRemoteDataSource.addConversationListener(listener);
  // }

  // @override
  // List<ConversationModel> getConversations() {
  //   return _conversationRemoteDataSource.getConversations();
  // }

  // @override
  // void removeConversationListener(
  //     Function(List<ConversationModel> p1) listener) {
  //   _conversationRemoteDataSource.removeConversationListener(listener);
  // }

  // @override
  // void addMessageListener(
  //     String conversationId, Function(List<MessageModel> p1) listener) {
  //   _conversationRemoteDataSource.addMessageListener(conversationId, listener);
  // }

  // @override
  // List<MessageModel>? initChat(String conversationId) {
  //   return _conversationRemoteDataSource.initChat(conversationId);
  // }

  // @override
  // void removeMessageListener(
  //     String conversationId, Function(List<MessageModel> p1) listener) {
  //   _conversationRemoteDataSource.removeMessageListener(
  //       conversationId, listener);
  // }

  // @override
  // void sendTextMessage(String conversationId, String message) {
  //   _conversationRemoteDataSource.sendTextMessage(conversationId, message);
  // }

  // @override
  // void connect() {
  //   final token = _authenLocalDataSrc.getAccessToken();
  //   _conversationRemoteDataSource.setAuthToken(token!);
  //   _conversationRemoteDataSource.connect();
  // }

  // @override
  // void disconnect() {
  //   _conversationRemoteDataSource.disconnect();
  // }
}
