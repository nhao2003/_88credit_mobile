import 'package:_88credit_mobile/features/data/models/user.dart';
import '../../../core/utils/convert_number.dart';
import '../../../core/utils/validate_utils.dart';
import '../../domain/entities/loan_request.dart';
import '../../domain/enums/loan_contract_request_status.dart';
import '../../domain/enums/loan_reason_types.dart';
import 'bank_card.dart';

class LoanRequestModel extends LoanRequestEntity {
  const LoanRequestModel({
    super.id,
    super.status,
    super.senderId,
    super.sender,
    super.receiverId,
    super.receiver,
    super.description,
    super.loanAmount,
    super.interestRate,
    super.overdueInterestRate,
    super.loanTenureMonths,
    super.loanReasonType,
    super.loanReason,
    super.videoConfirmationUrl,
    super.portaitPhotoUrl,
    super.idCardFrontPhotoUrl,
    super.idCardBackPhotoUrl,
    super.senderBankCardId,
    super.receiverBankCardId,
    super.rejectedReason,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.senderBankCard,
    super.receiverBankCard,
  });

  factory LoanRequestModel.fromJson(Map<String, dynamic> json) {
    return LoanRequestModel(
      id: json['id'],
      status: json['status'] != null
          ? LoanContractRequestStatus.parse(json['status'])
          : null,
      senderId: json['senderId'],
      sender:
          json['sender'] != null ? UserModel.fromJson(json['sender']) : null,
      receiverId: json['receiverId'],
      receiver: json['receiver'] != null
          ? UserModel.fromJson(json['receiver'])
          : null,
      description: json['description'],
      loanAmount: ValidateUtils.toDoubleJson(json['loanAmount']),
      interestRate: ConverNumber.convertIntToDouble(json['interestRate']),
      overdueInterestRate:
          ConverNumber.convertIntToDouble(json['overdueInterestRate']),
      loanTenureMonths: json['loanTenureMonths'],
      loanReasonType: json['loanReasonType'] != null
          ? LoanReasonTypes.parse(json['loanReasonType'])
          : null,
      loanReason: json['loanReason'],
      videoConfirmationUrl: json['videoConfirmationUrl'],
      portaitPhotoUrl: json['portaitPhotoUrl'],
      idCardFrontPhotoUrl: json['idCardFrontPhotoUrl'],
      idCardBackPhotoUrl: json['idCardBackPhotoUrl'],
      senderBankCardId: json['senderBankCardId'],
      receiverBankCardId: json['receiverBankCardId'],
      rejectedReason: json['rejectedReason'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      senderBankCard: json['senderBankCard'] != null
          ? BankCardModel.fromJson(json['senderBankCard'])
          : null,
      receiverBankCard: json['receiverBankCard'] != null
          ? BankCardModel.fromJson(json['receiverBankCard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiver!.id,
      'description': description,
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'overdueInterestRate': overdueInterestRate,
      'loanTenureMonths': loanTenureMonths,
      'loanReasonType': loanReasonType.toString(),
      'loanReason': loanReason,
      'videoConfirmationUrl': videoConfirmationUrl,
      'portaitPhotoUrl': portaitPhotoUrl,
      'idCardFrontPhotoUrl': idCardFrontPhotoUrl,
      'idCardBackPhotoUrl': idCardBackPhotoUrl,
      "senderBankCardId": senderBankCardId,
    };
  }

  // from entity
  factory LoanRequestModel.fromEntity(LoanRequestEntity entity) {
    return LoanRequestModel(
      id: entity.id,
      status: entity.status,
      senderId: entity.senderId,
      sender: entity.sender,
      receiverId: entity.receiverId,
      receiver: entity.receiver,
      description: entity.description,
      loanAmount: entity.loanAmount,
      interestRate: entity.interestRate,
      overdueInterestRate: entity.overdueInterestRate,
      loanTenureMonths: entity.loanTenureMonths,
      loanReasonType: entity.loanReasonType,
      loanReason: entity.loanReason,
      videoConfirmationUrl: entity.videoConfirmationUrl,
      portaitPhotoUrl: entity.portaitPhotoUrl,
      idCardFrontPhotoUrl: entity.idCardFrontPhotoUrl,
      idCardBackPhotoUrl: entity.idCardBackPhotoUrl,
      senderBankCardId: entity.senderBankCardId,
      receiverBankCardId: entity.receiverBankCardId,
      rejectedReason: entity.rejectedReason,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      senderBankCard: entity.senderBankCard,
      receiverBankCard: entity.receiverBankCard,
    );
  }
}
