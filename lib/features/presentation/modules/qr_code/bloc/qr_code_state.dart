part of 'qr_code_bloc.dart';

final class QrCodeState extends Equatable {
  final String qrData;
  const QrCodeState({
    this.qrData = "",
  });

  QrCodeState copyWith({
    String? qrData,
  }) {
    return QrCodeState(
      qrData: qrData ?? this.qrData,
    );
  }

  @override
  List<Object> get props => [
        qrData,
      ];
}
