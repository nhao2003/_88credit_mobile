import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'message.dart';
import 'participant.dart';

// ignore: must_be_immutable
class ConversationEntitiy extends Equatable {
  final String id;
  final DateTime createdAt;
  final String? lastMessageId;
  final bool? isRead;
  final MessageEntity? lastMessage;
  final List<ParticipantEntity>? participants;
  late List<MessageEntity>? messages;
  final List<UserEntity>? users;

  ConversationEntitiy({
    required this.id,
    required this.createdAt,
    required this.lastMessageId,
    required this.isRead,
    required this.lastMessage,
    required this.participants,
    required this.messages,
    required this.users,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        lastMessageId,
        isRead,
        lastMessage,
        participants,
        messages,
        users,
      ];
}
