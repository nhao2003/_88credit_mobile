import 'package:_88credit_mobile/features/data/models/user.dart';
import '../../../domain/entities/chat/conversation.dart';
import 'message_model.dart';
import 'participant_model.dart';

// ignore: must_be_immutable
class ConversationModel extends ConversationEntitiy {
  const ConversationModel({
    required super.id,
    required super.createdAt,
    required super.lastMessage,
    required super.updatedAt,
    required super.participants,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,
      // participants: List<ParticipantModel>.from((json['participants'] ?? [])
      //     .map((e) => ParticipantModel.fromJson(e))
      //     .toList()),
      participants: List<String>.from(json['participants'] ?? []),
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'lastMessage': lastMessage,
      'participants': participants,
    };
  }
}
