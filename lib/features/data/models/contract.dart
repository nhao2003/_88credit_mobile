import 'dart:math';

import 'package:_88credit_mobile/features/data/models/user.dart';
import '../../../core/utils/validate_utils.dart';
import '../../domain/entities/contract.dart';
import '../../domain/enums/loan_reason_types.dart';
import 'bank_card.dart';

class ContractModel extends ContractEntity {
  const ContractModel({
    super.id,
    super.loanRequestId,
    super.lenderId,
    super.lenderBankCardId,
    super.borrowerId,
    super.borrowerBankCardId,
    super.transactionHash,
    super.loanReasonType,
    super.loanReason,
    super.amount,
    super.interestRate,
    super.tenureInMonths,
    super.overdueInterestRate,
    super.createdAt,
    super.lender,
    super.borrower,
    super.lenderBankCard,
    super.borrowerBankCard,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'],
      loanRequestId: json['loanRequestId'],
      lenderId: json['lenderId'],
      lenderBankCardId: json['lenderBankCardId'],
      borrowerId: json['borrowerId'],
      borrowerBankCardId: json['borrowerBankCardId'],
      loanReasonType: json['loanReasonType'] != null
          ? LoanReasonTypes.parse(json['loanReasonType'])
          : null,
      transactionHash: json['transactionHash'] ?? generateRandomHexString(),
      loanReason: json['loanReason'],
      amount: ValidateUtils.toDoubleJson(json['amount']),
      interestRate: ValidateUtils.toDoubleJson(json['interestRate']),
      tenureInMonths: ValidateUtils.toIntJson(json['tenureInMonths']),
      overdueInterestRate:
          ValidateUtils.toDoubleJson(json['overdueInterestRate']),
      createdAt: DateTime.parse(json['createdAt']),
      lender:
          json['lender'] != null ? UserModel.fromJson(json['lender']) : null,
      borrower: json['borrower'] != null
          ? UserModel.fromJson(json['borrower'])
          : null,
      lenderBankCard: json['lenderBankCard'] != null
          ? BankCardModel.fromJson(json['lenderBankCard'])
          : null,
      borrowerBankCard: json['borrowerBankCard'] != null
          ? BankCardModel.fromJson(json['borrowerBankCard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanRequestId': loanRequestId,
      'lenderId': lenderId,
      'lenderBankCardId': lenderBankCardId,
      'borrowerId': borrowerId,
      'borrowerBankCardId': borrowerBankCardId,
      'loanReasonType': loanReasonType?.toString(),
      'loanReason': loanReason,
      'amount': amount,
      'interestRate': interestRate,
      'tenureInMonths': tenureInMonths,
      'overdue_interest_rate': overdueInterestRate,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // from entity
  factory ContractModel.fromEntity(ContractEntity entity) {
    return ContractModel(
      id: entity.id,
      loanRequestId: entity.loanRequestId,
      lenderId: entity.lenderId,
      lenderBankCardId: entity.lenderBankCardId,
      borrowerId: entity.borrowerId,
      borrowerBankCardId: entity.borrowerBankCardId,
      loanReasonType: entity.loanReasonType,
      transactionHash: entity.transactionHash,
      loanReason: entity.loanReason,
      amount: entity.amount,
      interestRate: entity.interestRate,
      tenureInMonths: entity.tenureInMonths,
      overdueInterestRate: entity.overdueInterestRate,
      createdAt: entity.createdAt,
      lender: entity.lender,
      borrower: entity.borrower,
      lenderBankCard: entity.lenderBankCard,
      borrowerBankCard: entity.borrowerBankCard,
    );
  }
}

String generateRandomHexString() {
  const chars = '0123456789abcdefghijklmnopqrstuvwxyz';
  Random rand = Random.secure();
  return '0x${List.generate(64, (index) => chars[rand.nextInt(36)]).join('')}';
}
