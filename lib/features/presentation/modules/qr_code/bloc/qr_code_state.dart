part of 'qr_code_bloc.dart';

final class QrCodeState extends Equatable {
  final String qrData;
  final String userID;
  const QrCodeState({
    this.qrData = "",
    this.userID = "",
  });

  QrCodeState copyWith({
    String? qrData,
    String? userID,
  }) {
    return QrCodeState(
      qrData: qrData ?? this.qrData,
      userID: userID ?? this.userID,
    );
  }

  @override
  List<Object> get props => [
        qrData,
        userID,
      ];
}
