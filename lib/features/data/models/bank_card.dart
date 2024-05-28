import '../../domain/entities/bank_card.dart';
import 'bank.dart';

class BankCardModel extends BankCardEntity {
  const BankCardModel({
    super.id,
    super.isPrimary,
    super.userId,
    super.bankId,
    super.bank,
    super.cardNumber,
    super.branch,
    super.createdAt,
    super.deletedAt,
  });

  factory BankCardModel.fromJson(Map<String, dynamic> json) {
    return BankCardModel(
      id: json['id'],
      isPrimary: json['isPrimary'],
      userId: json['userId'],
      bankId: json['bankId'],
      bank: json['bank'] != null ? BankModel.fromJson(json['bank']) : null,
      cardNumber: json['cardNumber'],
      branch: json['branch'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankId': bank!.id,
      'cardNumber': cardNumber,
    };
  }

  // from entity
  factory BankCardModel.fromEntity(BankCardEntity entity) {
    return BankCardModel(
      id: entity.id,
      isPrimary: entity.isPrimary,
      userId: entity.userId,
      bankId: entity.bankId,
      bank: entity.bank,
      cardNumber: entity.cardNumber,
      branch: entity.branch,
      createdAt: entity.createdAt,
      deletedAt: entity.deletedAt,
    );
  }
}
