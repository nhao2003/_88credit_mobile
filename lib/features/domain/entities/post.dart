import 'package:equatable/equatable.dart';
import '../enums/loan_reason_types.dart';
import '../enums/post_status.dart';
import 'user.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? userId;
  final UserEntity? user;
  final PostStatus? status;
  final LoanReasonTypes? loanReason;
  final String? loanReasonDescription;
  final bool? isLease;
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
    this.isLease,
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
        isLease,
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
    bool? isLease,
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
      isLease: isLease ?? this.isLease,
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
}
