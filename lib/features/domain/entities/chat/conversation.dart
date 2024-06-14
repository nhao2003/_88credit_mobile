import 'package:equatable/equatable.dart';
import 'message.dart';

// ignore: must_be_immutable
class ConversationEntitiy extends Equatable {
  final String id;
  final MessageEntity? lastMessage;
  final List<String>? participants;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ConversationEntitiy({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
    this.participants,
  });

  @override
  List<Object?> get props => [
        id,
        lastMessage,
        participants,
        createdAt,
        updatedAt,
      ];
}
