import 'package:_88credit_mobile/core/resources/data_state.dart';
import 'package:_88credit_mobile/features/domain/entities/contract.dart';
import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:_88credit_mobile/features/domain/usecases/contract/cancel_request.dart';
import 'package:_88credit_mobile/features/domain/usecases/contract/reject_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
import '../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../domain/usecases/contract/confirm_request.dart';
import '../../../../domain/usecases/contract/mark_paid_request.dart';
import '../../../../domain/usecases/contract/pay_loan_request.dart';

part 'request_detail_event.dart';
part 'request_detail_state.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  RequestDetailBloc() : super(const RequestDetailState()) {
    on<RequestDetailEvent>((event, emit) {});
    on<CancelRequest>(_cancelRequest);
    on<RejectRequest>(_rejectRequest);
    on<ConfirmRequest>(_confirmRequest);
    on<PaymentRequest>(_paymentRequest);
    on<MarkPaidRequest>(_markPaidRequest);
    on<ChangeRequestStatus>(_changeRequestStatus);
    on<InitRequestState>((event, emit) {
      emit(state.copyWith(
        cancelStatus: CancelStatus.initial,
        rejectStatus: RejectStatus.initial,
        confirmStatus: ConfirmStatus.initial,
        paymentStatus: PaymentStatus.initial,
        markPaidStatus: MarkPaidStatus.initial,
      ));
    });
  }

  void _cancelRequest(
    CancelRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    emit(state.copyWith(cancelStatus: CancelStatus.loading));
    try {
      CancelRequestUseCase cancelRequestUseCase = sl<CancelRequestUseCase>();
      final result = await cancelRequestUseCase(params: event.request);

      if (result is DataSuccess) {
        emit(state.copyWith(
          cancelStatus: CancelStatus.success,
        ));
      } else {
        emit(state.copyWith(
            cancelStatus: CancelStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          cancelStatus: CancelStatus.failure, failureMessage: e.toString()));
    }
  }

  void _rejectRequest(
    RejectRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(rejectStatus: RejectStatus.loading));
      RejectRequestUseCase rejectRequestUseCase = sl<RejectRequestUseCase>();
      final result = await rejectRequestUseCase(params: event.request);

      if (result is DataSuccess) {
        emit(state.copyWith(
          rejectStatus: RejectStatus.success,
        ));
      } else {
        emit(state.copyWith(
            rejectStatus: RejectStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          rejectStatus: RejectStatus.failure, failureMessage: e.toString()));
    }
  }

  void _confirmRequest(
    ConfirmRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(confirmStatus: ConfirmStatus.loading));
      ConfirmRequestUseCase confirmRequestUseCase = sl<ConfirmRequestUseCase>();
      final result = await confirmRequestUseCase(params: event.request);
      if (result is DataSuccess) {
        emit(state.copyWith(
          confirmStatus: ConfirmStatus.success,
        ));
      } else {
        emit(state.copyWith(
            confirmStatus: ConfirmStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          confirmStatus: ConfirmStatus.failure, failureMessage: e.toString()));
    }
  }

  void _paymentRequest(
    PaymentRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(paymentStatus: PaymentStatus.loading));
      final result =
          await sl<PayLoanRequestUsecase>().call(params: event.request.id);
      if (result is DataSuccess) {
        emit(state.copyWith(
          paymentStatus: PaymentStatus.success,
        ));
      } else {
        emit(state.copyWith(
            paymentStatus: PaymentStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          paymentStatus: PaymentStatus.failure, failureMessage: e.toString()));
    }
  }

  void _markPaidRequest(
    MarkPaidRequest event,
    Emitter<RequestDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(markPaidStatus: MarkPaidStatus.loading));
      final result =
          await sl<MarkPaidRequestUseCase>().call(params: event.request);
      if (result is DataSuccess) {
        emit(state.copyWith(
          markPaidStatus: MarkPaidStatus.success,
        ));
      } else {
        emit(state.copyWith(
            markPaidStatus: MarkPaidStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          markPaidStatus: MarkPaidStatus.failure,
          failureMessage: e.toString()));
    }
  }

  void _changeRequestStatus(
    ChangeRequestStatus event,
    Emitter<RequestDetailState> emit,
  ) async {
    emit(state.copyWith(requestStatus: event.status));
  }
}
