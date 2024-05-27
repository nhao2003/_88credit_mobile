import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import '../enums/loan_contract_request_status.dart';
import '../enums/loan_reason_types.dart';
import 'bank_card.dart';

class LoanRequestEntity extends Equatable {
  final String? id;
  final LoanContractRequestStatus? status;
  final String? senderId;
  final UserEntity? sender;
  final String? receiverId;
  final UserEntity? receiver;
  final String? description;
  final double? loanAmount;
  final double? interestRate;
  final double? overdueInterestRate;
  final int? loanTenureMonths;
  final LoanReasonTypes? loanReasonType;
  final String? loanReason;
  final String? videoConfirmationUrl;
  final String? portaitPhotoUrl;
  final String? idCardFrontPhotoUrl;
  final String? idCardBackPhotoUrl;
  final String? senderBankCardId;
  final BankCardEntity? senderBankCard;
  final String? receiverBankCardId;
  final BankCardEntity? receiverBankCard;
  final String? rejectedReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const LoanRequestEntity({
    this.id,
    this.status,
    this.senderId,
    this.sender,
    this.receiverId,
    this.receiver,
    this.description,
    this.loanAmount,
    this.interestRate,
    this.overdueInterestRate,
    this.loanTenureMonths,
    this.loanReasonType,
    this.loanReason,
    this.videoConfirmationUrl,
    this.portaitPhotoUrl,
    this.idCardFrontPhotoUrl,
    this.idCardBackPhotoUrl,
    this.senderBankCardId,
    this.receiverBankCardId,
    this.rejectedReason,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.senderBankCard,
    this.receiverBankCard,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        senderId,
        sender,
        receiverId,
        receiver,
        description,
        loanAmount,
        interestRate,
        overdueInterestRate,
        loanTenureMonths,
        loanReasonType,
        loanReason,
        videoConfirmationUrl,
        portaitPhotoUrl,
        idCardFrontPhotoUrl,
        idCardBackPhotoUrl,
        senderBankCardId,
        receiverBankCardId,
        rejectedReason,
        createdAt,
        updatedAt,
        deletedAt,
        senderBankCard,
        receiverBankCard,
      ];

  LoanRequestEntity copyWith({
    String? id,
    LoanContractRequestStatus? status,
    String? senderId,
    UserEntity? sender,
    String? receiverId,
    UserEntity? receiver,
    String? description,
    double? loanAmount,
    double? interestRate,
    double? overdueInterestRate,
    int? loanTenureMonths,
    LoanReasonTypes? loanReasonType,
    String? loanReason,
    String? videoConfirmation,
    String? portaitPhoto,
    String? idCardFrontPhoto,
    String? idCardBackPhoto,
    String? senderBankCardId,
    String? receiverBankCardId,
    String? rejectedReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    BankCardEntity? senderBankCard,
    BankCardEntity? receiverBankCard,
  }) {
    return LoanRequestEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      senderId: senderId ?? this.senderId,
      sender: sender ?? this.sender,
      receiverId: receiverId ?? this.receiverId,
      receiver: receiver ?? this.receiver,
      description: description ?? this.description,
      loanAmount: loanAmount ?? this.loanAmount,
      interestRate: interestRate ?? this.interestRate,
      overdueInterestRate: overdueInterestRate ?? this.overdueInterestRate,
      loanTenureMonths: loanTenureMonths ?? this.loanTenureMonths,
      loanReasonType: loanReasonType ?? this.loanReasonType,
      loanReason: loanReason ?? this.loanReason,
      videoConfirmationUrl: videoConfirmation ?? videoConfirmationUrl,
      portaitPhotoUrl: portaitPhoto ?? portaitPhotoUrl,
      idCardFrontPhotoUrl: idCardFrontPhoto ?? idCardFrontPhotoUrl,
      idCardBackPhotoUrl: idCardBackPhoto ?? idCardBackPhotoUrl,
      senderBankCardId: senderBankCardId ?? this.senderBankCardId,
      receiverBankCardId: receiverBankCardId ?? this.receiverBankCardId,
      rejectedReason: rejectedReason ?? this.rejectedReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      senderBankCard: senderBankCard ?? this.senderBankCard,
      receiverBankCard: receiverBankCard ?? this.receiverBankCard,
    );
  }
}
