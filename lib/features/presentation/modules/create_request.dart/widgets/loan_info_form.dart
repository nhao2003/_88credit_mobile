import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/domain/enums/loan_reason_types.dart';
import 'package:_88credit_mobile/features/presentation/modules/create_post/widgets/base_row_text_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/constants/constants.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/base_dropdown_button.dart';
import '../../../globalwidgets/base_textfield.dart';
import '../bloc/create_request_bloc.dart';

// ignore: must_be_immutable
class LoanInfoForm extends StatelessWidget {
  final bool isvisible;

  final TextEditingController loanAmountTextController;
  final TextEditingController interestRateTextController;
  final TextEditingController overdueInterestRateTextController;
  final TextEditingController tenureMonthsTextController;
  final TextEditingController loanReasonTextController;
  final TextEditingController discriptionTextController;

  LoanInfoForm({
    required this.isvisible,
    required this.loanAmountTextController,
    required this.interestRateTextController,
    required this.overdueInterestRateTextController,
    required this.tenureMonthsTextController,
    required this.loanReasonTextController,
    required this.discriptionTextController,
    super.key,
  });

  final FocusNode _discriptionFocusNode = FocusNode();
  final FocusNode _moneyFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final FocusNode _overInterestFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _loanReasonFocusNode = FocusNode();

  List<String> timeTypes = ["Tháng"];
  String timeValue = 'Tháng';
  void setTimeValue(String? value) {
    timeValue = value!;
  }

  String? validateMoney(String? value) {
    try {
      if (value!.trim().isEmpty) return 'Số tiền không được rỗng';
      // parse double
      final doubleValue = double.tryParse(value.trim());
      // check 0 < value < 1000000000
      if (doubleValue != null) {
        if (doubleValue <= minMoney) return 'Số tiền phải lớn hơn $minMoney';
        if (doubleValue >= maxMoney) {
          return 'Số tiền phải nhỏ hơn 1 tỷ';
        }
      } else {
        return 'Số tiền không hợp lệ';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? validateInterestRate(String? value) {
    try {
      if (value!.trim().isEmpty) return 'Lãi suất không được rỗng';
      // parse double
      final doubleValue = double.tryParse(value.trim());
      // check 0 < value < 1.66
      if (doubleValue != null) {
        if (doubleValue <= minInterestRate) {
          return 'Lãi suất phải lớn hơn $minInterestRate%';
        }
        if (doubleValue >= maxInterestRate) {
          return 'Lãi suất phải nhỏ hơn $maxInterestRate%';
        }
      } else {
        return 'Lãi suất không hợp lệ';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? validateTenureMonths(String? value) {
    try {
      if (value!.trim().isEmpty) return 'Kỳ hạn không được rỗng';
      // parse double
      final doubleValue = double.tryParse(value.trim());
      // check 0 < value < 1000000000
      if (doubleValue != null) {
        if (doubleValue <= minTenureMonths) {
          return 'Kỳ hạn phải lớn hơn $minTenureMonths';
        }
        if (doubleValue >= maxTenureMonths) {
          return 'Kỳ hạn phải nhỏ hơn $maxTenureMonths';
        }
      } else {
        return 'Kỳ hạn không hợp lệ';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isvisible,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mô tả yêu cầu",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseTextField(
              minLines: 3,
              maxLines: 10,
              maxLength: 1000,
              focusNode: _discriptionFocusNode,
              nexFocusNode: _moneyFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: discriptionTextController,
              labelText: 'Mô tả yêu cầu vay',
              hintText: 'Mô tả yêu cầu vay',
              validator: (value) =>
                  (value!.trim().isNotEmpty) ? null : 'Mô tả không được rỗng',
            ),
            const SizedBox(height: 5),
            Text(
              "Số tiền",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseTextField(
              focusNode: _moneyFocusNode,
              nexFocusNode: _interestFocusNode,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: loanAmountTextController,
              labelText: 'Số tiền cần vay (VNĐ)',
              hintText: "Nhập số tiền mong muốn",
              validator: validateMoney,
            ),
            const SizedBox(height: 10),
            Text(
              "Lãi suất",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseRowTextDropdown(
              focusNode: _interestFocusNode,
              nexFocusNode: _overInterestFocusNode,
              textInputAction: TextInputAction.next,
              labelText: 'Lãi suất mong muốn',
              hintText: "Nhập lãi suất mong muốn",
              controller: interestRateTextController,
              timeValue: timeValue,
              onChangeTimeValue: setTimeValue,
              validator: validateInterestRate,
            ),
            const SizedBox(height: 10),
            Text(
              "Lãi suất quá hạn",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseRowTextDropdown(
              focusNode: _overInterestFocusNode,
              nexFocusNode: _timeFocusNode,
              textInputAction: TextInputAction.next,
              labelText: 'Lãi suất quá hạn',
              hintText: "Nhập lãi suất quá hạn",
              controller: overdueInterestRateTextController,
              timeValue: timeValue,
              onChangeTimeValue: setTimeValue,
              validator: validateInterestRate,
            ),
            const SizedBox(height: 10),
            Text(
              "Kỳ hạn",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BaseRowTextDropdown(
              focusNode: _timeFocusNode,
              nexFocusNode: _loanReasonFocusNode,
              textInputAction: TextInputAction.done,
              labelText: 'Kỳ hạn mong muốn',
              hintText: "Nhập kỳ hạn mong muốn",
              controller: tenureMonthsTextController,
              timeValue: timeValue,
              onChangeTimeValue: setTimeValue,
              validator: validateTenureMonths,
            ),
            const SizedBox(height: 10),
            Text(
              "Lý do vay",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CreateRequestBloc, CreateRequestState>(
              builder: (context, state) {
                return BaseDropdownButton(
                  title: "Loại lý do vay",
                  hint: "Chọn loại lý do vay",
                  value: state.loanReasonType,
                  items: LoanReasonTypes.toMap().entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        overflow: TextOverflow.visible,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<CreateRequestBloc>().add(
                            ChangeLoanReasonEvent(value as LoanReasonTypes),
                          );
                    }
                  },
                  onSaved: (value) {
                    if (value == null) return;
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            BaseTextField(
              minLines: 3,
              maxLines: 10,
              maxLength: 1000,
              focusNode: _loanReasonFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: loanReasonTextController,
              labelText: 'Mô tả lý do vay',
              hintText: 'Mô tả lý do vay',
              onSaved: (value) {
                // loanReason = value!.trim();
              },
              validator: (value) =>
                  (value!.trim().isNotEmpty) ? null : 'Lý do không được rỗng',
            ),
          ],
        ),
      ),
    );
  }
}
