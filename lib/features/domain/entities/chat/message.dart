import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String? conversation;
  final String senderId;
  final Map<String, dynamic> content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MessageEntity({
    required this.id,
    this.conversation,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        conversation,
        senderId,
        content,
        createdAt,
        updatedAt,
      ];

  bool get isMine => senderId == 'me';
}
