import 'package:equatable/equatable.dart';

class FrontCardInfo extends Equatable {
  final String? id;
  final String? name;
  final String? birthDay;
  final String? gender;
  final String? nationality;
  final String? originLocation;
  final String? recentLocation;
  final String? cardType;

  const FrontCardInfo({
    this.id,
    this.name,
    this.birthDay,
    this.gender,
    this.nationality,
    this.originLocation,
    this.recentLocation,
    this.cardType,
  });

  factory FrontCardInfo.fromJson(Map<String, dynamic> json) {
    return FrontCardInfo(
      id: json['frontIdentityCardOcrResult']['id'],
      name: json['frontIdentityCardOcrResult']['name'],
      birthDay: json['frontIdentityCardOcrResult']['birth_day'],
      gender: json['frontIdentityCardOcrResult']['gender'],
      nationality: json['frontIdentityCardOcrResult']['nationality'],
      originLocation: json['frontIdentityCardOcrResult']['origin_location'],
      recentLocation: json['frontIdentityCardOcrResult']['recent_location'],
      cardType: json['frontIdentityCardOcrResult']['card_type'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        birthDay,
        gender,
        nationality,
        originLocation,
        recentLocation,
        cardType,
      ];

  // to string
  @override
  String toString() {
    return 'FrontCardInfo { id: $id, name: $name, birthDay: $birthDay, gender: $gender, nationality: $nationality, originLocation: $originLocation, recentLocation: $recentLocation, cardType: $cardType }';
  }
}
