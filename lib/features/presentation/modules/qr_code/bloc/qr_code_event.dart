part of 'qr_code_bloc.dart';

sealed class QrCodeEvent extends Equatable {
  const QrCodeEvent();

  @override
  List<Object> get props => [];
}

class GenerateQrCode extends QrCodeEvent {
  final String qrData;

  const GenerateQrCode(this.qrData);

  @override
  List<Object> get props => [qrData];
}

class GetUserId extends QrCodeEvent {
  const GetUserId();
}
