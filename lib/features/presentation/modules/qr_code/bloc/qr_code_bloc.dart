import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
import '../../../../domain/usecases/authentication/get_user_id.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(const QrCodeState()) {
    on<QrCodeEvent>((event, emit) {});
    on<GenerateQrCode>(_onChangeQrData);
    on<GetUserId>(_onGetUserId);
  }

  Future<void> _onChangeQrData(
    GenerateQrCode event,
    Emitter<QrCodeState> emit,
  ) async {
    emit(state.copyWith(qrData: event.qrData));
  }

  Future<void> _onGetUserId(
    GetUserId event,
    Emitter<QrCodeState> emit,
  ) async {
    final userID = await sl<GetUserIdUseCase>()();
    emit(state.copyWith(userID: userID));
  }
}
