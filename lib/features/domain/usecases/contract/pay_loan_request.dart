import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/request_repository.dart';

class PayLoanRequestUsecase implements UseCase<DataState<void>, String?> {
  final RequestRepository _requestRepository;

  PayLoanRequestUsecase(this._requestRepository);

  @override
  Future<DataState<FlutterZaloPayStatus>> call({String? params}) async {
    if (params == null) {
      return Future.value(DataFailed(Exception('Params is null')));
    }

    final res = await _requestRepository.payLoanRequest(params);
    if (res is DataSuccess) {
      String? zlpToken = res.data?.embedData?['zp_trans_token'];
      if (zlpToken == null) {
        return DataFailed(
            Exception('Lỗi khi thanh toán. Vui lòng thử lại sau'));
      }
      final status = await FlutterZaloPaySdk.payOrder(zpToken: zlpToken);
      return DataSuccess(status);
    } else {
      return DataFailed(Exception('Lỗi khi thanh toán. Vui lòng thử lại sau'));
    }
  }
}
