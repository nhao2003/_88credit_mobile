import 'package:equatable/equatable.dart';

class EkycRequestModel extends Equatable {
  final String? id;
  final String? userId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EkycRequestModel({
    this.id,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory EkycRequestModel.fromJson(Map<String, dynamic> json) {
    return EkycRequestModel(
      id: json['_id'],
      userId: json['userId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [id, userId, status, createdAt, updatedAt];
}
