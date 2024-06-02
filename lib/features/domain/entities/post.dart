import 'package:equatable/equatable.dart';
import '../enums/loan_reason_types.dart';
import '../enums/post_status.dart';
import '../enums/post_type.dart';
import 'user.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? userId;
  final UserEntity? user;
  final PostStatus? status;
  final LoanReasonTypes? loanReason;
  final String? loanReasonDescription;
  final PostTypes? type;
  final String? title;
  final String? description;
  final List<String>? images;
  final double? interestRate;
  final double? amount;
  final int? duration;
  final double? overdueInterestRate;
  final double? maxInterestRate;
  final double? maxAmount;
  final int? maxDuration;
  final double? maxOverdueInterestRate;
  final String? rejectionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PostEntity({
    this.id,
    this.userId,
    this.user,
    this.status,
    this.loanReason,
    this.loanReasonDescription,
    this.type,
    this.title,
    this.description,
    this.images,
    this.interestRate,
    this.amount,
    this.duration,
    this.overdueInterestRate,
    this.maxInterestRate,
    this.maxAmount,
    this.maxDuration,
    this.maxOverdueInterestRate,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        user,
        status,
        loanReason,
        loanReasonDescription,
        type,
        title,
        description,
        images,
        interestRate,
        amount,
        duration,
        overdueInterestRate,
        maxInterestRate,
        maxAmount,
        maxDuration,
        maxOverdueInterestRate,
        rejectionReason,
        createdAt,
        updatedAt,
      ];

  PostEntity copyWith({
    String? id,
    String? userId,
    UserEntity? user,
    PostStatus? status,
    LoanReasonTypes? loanReason,
    String? loanReasonDescription,
    PostTypes? type,
    String? title,
    String? description,
    List<String>? images,
    double? interestRate,
    double? amount,
    int? duration,
    double? overdueInterestRate,
    double? maxInterestRate,
    double? maxAmount,
    int? maxDuration,
    double? maxOverdueInterestRate,
    String? rejectionReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      status: status ?? this.status,
      loanReason: loanReason ?? this.loanReason,
      loanReasonDescription:
          loanReasonDescription ?? this.loanReasonDescription,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      interestRate: interestRate ?? this.interestRate,
      amount: amount ?? this.amount,
      duration: duration ?? this.duration,
      overdueInterestRate: overdueInterestRate ?? this.overdueInterestRate,
      maxInterestRate: maxInterestRate ?? this.maxInterestRate,
      maxAmount: maxAmount ?? this.maxAmount,
      maxDuration: maxDuration ?? this.maxDuration,
      maxOverdueInterestRate:
          maxOverdueInterestRate ?? this.maxOverdueInterestRate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // toString
  @override
  String toString() {
    return 'PostEntity(id: $id, userId: $userId, user: $user, status: $status, loanReason: $loanReason, loanReasonDescription: $loanReasonDescription, type: $type, title: $title, description: $description, images: $images, interestRate: $interestRate, amount: $amount, duration: $duration, overdueInterestRate: $overdueInterestRate, maxInterestRate: $maxInterestRate, maxAmount: $maxAmount, maxDuration: $maxDuration, maxOverdueInterestRate: $maxOverdueInterestRate, rejectionReason: $rejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
