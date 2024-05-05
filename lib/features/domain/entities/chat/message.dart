import 'package:_88credit_mobile/features/domain/enums/message_types.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String conversationId;
  final String senderId;
  final MessageTypes contentType;
  final Map<String, dynamic> content;
  final DateTime sentAt;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.contentType,
    required this.content,
    required this.sentAt,
  });

  @override
  List<Object?> get props => [
        id,
        conversationId,
        senderId,
        contentType,
        content,
        sentAt,
      ];

  bool get isMine => senderId == 'me';
}
