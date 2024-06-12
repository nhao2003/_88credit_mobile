import 'package:equatable/equatable.dart';

class BackCardInfo extends Equatable {
  final String? issuePlace;
  final String? features;
  final String? issueDate;
  final List<dynamic>? mrz;

  const BackCardInfo({
    this.issuePlace,
    this.features,
    this.issueDate,
    this.mrz,
  });

  factory BackCardInfo.fromJson(Map<String, dynamic> json) {
    return BackCardInfo(
      issuePlace: json['backIdentityCardOcrResult']['issue_place'],
      features: json['backIdentityCardOcrResult']['features'],
      issueDate: json['backIdentityCardOcrResult']['issue_date'],
      mrz: json['backIdentityCardOcrResult']['mrz'],
    );
  }

  @override
  List<Object?> get props => [
        issuePlace,
        features,
        issueDate,
        mrz,
      ];

  // to string
  @override
  String toString() {
    return 'BackCardInfo { issuePlace: $issuePlace, features: $features, issueDate: $issueDate, mrz: $mrz }';
  }
}
