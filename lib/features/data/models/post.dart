import 'package:_88credit_mobile/core/utils/validate_utils.dart';
import '../../domain/entities/post.dart';
import '../../domain/enums/loan_reason_types.dart';
import '../../domain/enums/post_status.dart';

class PostModel extends PostEntity {
  const PostModel({
    super.id,
    super.userId,
    super.user,
    super.status,
    super.loanReason,
    super.loanReasonDescription,
    super.isLease,
    super.title,
    super.description,
    super.images,
    super.interestRate,
    super.amount,
    super.duration,
    super.overdueInterestRate,
    super.maxInterestRate,
    super.maxAmount,
    super.maxDuration,
    super.maxOverdueInterestRate,
    super.rejectionReason,
    super.createdAt,
    super.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      // user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      status: json['status'] != null ? PostStatus.parse(json['status']) : null,
      loanReason: json['loanReason'] != null
          ? LoanReasonTypes.parse(json['loanReason'])
          : null,
      loanReasonDescription: json['loanReasonDescription'],
      isLease: json['isLease'],
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      interestRate: ValidateUtils.toDoubleJson(json['interestRate']),
      amount: ValidateUtils.toDoubleJson(json['amount']),
      duration: ValidateUtils.toIntJson(json['duration']),
      overdueInterestRate:
          ValidateUtils.toDoubleJson(json['overdueInterestRate']),
      maxInterestRate: ValidateUtils.toDoubleJson(json['maxInterestRate']),
      maxAmount: ValidateUtils.toDoubleJson(json['maxAmount']),
      maxDuration: ValidateUtils.toIntJson(json['maxDuration']),
      maxOverdueInterestRate:
          ValidateUtils.toDoubleJson(json['maxOverdueInterestRate']),
      rejectionReason: json['rejectionReason'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isLease": isLease,
      "title": title,
      "description": description,
      "images": images,
      "loanReason": loanReason.toString(),
      "loanReasonDescription": loanReasonDescription,
      "interestRate": interestRate ?? 0,
      "amount": amount ?? 0,
      "duration": duration ?? 0,
      "overdueInterestRate": overdueInterestRate ?? 0,
      "maxInterestRate": maxInterestRate ?? 0,
      "maxAmount": maxAmount ?? 0,
      "maxDuration": maxDuration ?? 0,
      "maxOverdueInterestRate": maxOverdueInterestRate ?? 0,
    };
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      userId: entity.userId,
      user: entity.user,
      status: entity.status,
      loanReason: entity.loanReason,
      loanReasonDescription: entity.loanReasonDescription,
      isLease: entity.isLease,
      title: entity.title,
      description: entity.description,
      images: entity.images,
      interestRate: entity.interestRate,
      amount: entity.amount,
      duration: entity.duration,
      overdueInterestRate: entity.overdueInterestRate,
      maxInterestRate: entity.maxInterestRate,
      maxAmount: entity.maxAmount,
      maxDuration: entity.maxDuration,
      maxOverdueInterestRate: entity.maxOverdueInterestRate,
      rejectionReason: entity.rejectionReason,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
