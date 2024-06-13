import 'package:_88credit_mobile/features/domain/entities/bank_card.dart';
import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import '../enums/loan_reason_types.dart';

class ContractEntity extends Equatable {
  final String? id;
  final String? loanRequestId;
  final String? lenderId;
  final String? lenderBankCardId;
  final String? borrowerId;
  final String? borrowerBankCardId;
  final LoanReasonTypes? loanReasonType;
  final String? loanReason;
  final String? transactionHash;
  final double? amount;
  final double? interestRate;
  final int? tenureInMonths;
  final double? overdueInterestRate;
  final DateTime? createdAt;
  final UserEntity? borrower;
  final UserEntity? lender;
  final BankCardEntity? borrowerBankCard;
  final BankCardEntity? lenderBankCard;

  const ContractEntity({
    this.id,
    this.loanRequestId,
    this.lenderId,
    this.lenderBankCardId,
    this.borrowerId,
    this.borrowerBankCardId,
    this.loanReasonType,
    this.transactionHash,
    this.loanReason,
    this.amount,
    this.interestRate,
    this.tenureInMonths,
    this.overdueInterestRate,
    this.createdAt,
    this.lender,
    this.borrower,
    this.lenderBankCard,
    this.borrowerBankCard,
  });

  @override
  List<Object?> get props => [
        id,
        loanRequestId,
        lenderId,
        lenderBankCardId,
        borrowerId,
        borrowerBankCardId,
        loanReasonType,
        loanReason,
        transactionHash,
        amount,
        interestRate,
        tenureInMonths,
        overdueInterestRate,
        createdAt,
        lender,
        borrower,
        lenderBankCard,
        borrowerBankCard,
      ];

  ContractEntity copyWith({
    String? id,
    String? loanContractRequestId,
    String? contractTemplateId,
    String? lenderId,
    UserEntity? lender,
    String? lenderBankCardId,
    String? borrowerId,
    UserEntity? borrower,
    String? borrowerBankCardId,
    String? transactionHash,
    LoanReasonTypes? loanReasonType,
    String? loanReason,
    double? amount,
    double? interestRate,
    int? tenureInMonths,
    double? overdueInterestRate,
    DateTime? createdAt,
    DateTime? expiredAt,
    BankCardEntity? lenderBankCard,
    BankCardEntity? borrowerBankCard,
  }) {
    return ContractEntity(
      id: id ?? this.id,
      loanRequestId: loanContractRequestId ?? loanRequestId,
      lenderId: lenderId ?? lenderId,
      lenderBankCardId: lenderBankCardId ?? this.lenderBankCardId,
      borrowerId: borrowerId ?? borrowerId,
      borrowerBankCardId: borrowerBankCardId ?? this.borrowerBankCardId,
      loanReasonType: loanReasonType ?? this.loanReasonType,
      loanReason: loanReason ?? this.loanReason,
      transactionHash: transactionHash ?? this.transactionHash,
      amount: amount ?? this.amount,
      interestRate: interestRate ?? this.interestRate,
      tenureInMonths: tenureInMonths ?? this.tenureInMonths,
      overdueInterestRate: overdueInterestRate ?? this.overdueInterestRate,
      createdAt: createdAt ?? this.createdAt,
      lender: lender ?? this.lender,
      borrower: borrower ?? this.borrower,
      lenderBankCard: lenderBankCard ?? this.lenderBankCard,
      borrowerBankCard: borrowerBankCard ?? this.borrowerBankCard,
    );
  }
}
