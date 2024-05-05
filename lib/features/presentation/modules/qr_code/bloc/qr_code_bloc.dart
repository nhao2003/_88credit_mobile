import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(const QrCodeState()) {
    on<QrCodeEvent>((event, emit) {});
    on<GenerateQrCode>(_onChangeQrData);
  }

  Future<void> _onChangeQrData(
    GenerateQrCode event,
    Emitter<QrCodeState> emit,
  ) async {
    emit(state.copyWith(qrData: event.qrData));
  }
}
