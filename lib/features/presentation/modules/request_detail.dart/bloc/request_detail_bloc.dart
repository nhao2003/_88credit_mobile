import 'package:_88credit_mobile/features/domain/entities/contract.dart';
import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/enums/loan_contract_request_status.dart';

part 'request_detail_event.dart';
part 'request_detail_state.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  RequestDetailBloc() : super(const RequestDetailState()) {
    on<RequestDetailEvent>((event, emit) {});
    on<RejectRequest>(_rejectRequest);
    on<ConfirmRequest>(_confirmRequest);
    on<ChangeRequestStatus>(_changeRequestStatus);
  }

  void _rejectRequest(
    RejectRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    emit(state.copyWith(rejectStatus: RejectStatus.loading));
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      emit(state.copyWith(rejectStatus: RejectStatus.success));
    });
  }

  void _confirmRequest(
    ConfirmRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: ConfirmStatus.loading));
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      emit(state.copyWith(
        confirmStatus: ConfirmStatus.success,
        requestStatus: LoanContractRequestStatus.waitingForPayment,
      ));
    });
  }

  void _changeRequestStatus(
    ChangeRequestStatus event,
    Emitter<RequestDetailState> emit,
  ) async {
    emit(state.copyWith(requestStatus: event.status));
  }
}
