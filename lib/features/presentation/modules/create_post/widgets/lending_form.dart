import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../config/constants/constants.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/base_textfield.dart';
import 'base_row_text_dropdown.dart';
import 'picker_images.dart';

// ignore: must_be_immutable
class LendingForm extends StatelessWidget {
  final bool isvisible;
  final GlobalKey<FormState> lendingFormKey;

  final FocusNode _moneyFocusNode = FocusNode();
  final FocusNode _maxMoneyFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final FocusNode _maxInterestFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _maxTimeFocusNode = FocusNode();
  final FocusNode _overdueFocusNode = FocusNode();
  final FocusNode _maxOverdueFocusNode = FocusNode();

  final TextEditingController lendingLoanAmountTextController;
  final TextEditingController lendingMaxLoanAmountTextController;
  final TextEditingController lendingInterestRateTextController;
  final TextEditingController lendingMaxInterestRateTextController;
  final TextEditingController lendingTenureMonthsTextController;
  final TextEditingController lendingMaxTenureMonthsTextController;
  final TextEditingController lendingOverdueInterestRateTextController;
  final TextEditingController lendingMaxOverdueInterestRateTextController;

  final List<String> timeTypes = ["Tháng"];
  String timeValue = 'Tháng';
  void setTimeValue(String? value) {
    timeValue = value!;
  }

  LendingForm({
    required this.isvisible,
    required this.lendingFormKey,
    required this.lendingLoanAmountTextController,
    required this.lendingMaxLoanAmountTextController,
    required this.lendingInterestRateTextController,
    required this.lendingMaxInterestRateTextController,
    required this.lendingTenureMonthsTextController,
    required this.lendingMaxTenureMonthsTextController,
    required this.lendingOverdueInterestRateTextController,
    required this.lendingMaxOverdueInterestRateTextController,
    super.key,
  });

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
        child: Form(
          key: lendingFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Số tiền",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseTextField(
                focusNode: _moneyFocusNode,
                nexFocusNode: _maxMoneyFocusNode,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: lendingLoanAmountTextController,
                labelText: 'Số tiền tối thiểu (VNĐ)',
                hintText: "Nhập số tiền tối thiểu cho vay",
                validator: validateMoney,
              ),
              const SizedBox(height: 10),
              BaseTextField(
                focusNode: _maxMoneyFocusNode,
                nexFocusNode: _interestFocusNode,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: lendingMaxLoanAmountTextController,
                labelText: 'Số tiền tối đa (VNĐ)',
                hintText: "Nhập số tiền tối đa cho vay",
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
                nexFocusNode: _maxInterestFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Lãi suất tối thiểu',
                hintText: "Nhập lãi suất tối thiểu",
                controller: lendingInterestRateTextController,
                timeValue: timeValue,
                onChangeTimeValue: setTimeValue,
                validator: validateInterestRate,
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _maxInterestFocusNode,
                nexFocusNode: _timeFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Lãi suất tối đa',
                hintText: "Nhập lãi suất tối đa",
                controller: lendingMaxInterestRateTextController,
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
                nexFocusNode: _maxTimeFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Kỳ hạn tối thiểu',
                hintText: "Nhập kỳ hạn tối thiểu",
                controller: lendingTenureMonthsTextController,
                timeValue: timeValue,
                onChangeTimeValue: setTimeValue,
                validator: validateTenureMonths,
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _maxTimeFocusNode,
                nexFocusNode: _overdueFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Kỳ hạn tối đa',
                hintText: "Nhập kỳ hạn tối đa",
                controller: lendingMaxTenureMonthsTextController,
                timeValue: timeValue,
                onChangeTimeValue: setTimeValue,
                validator: validateTenureMonths,
              ),
              const SizedBox(height: 10),
              Text(
                "Lãi suất quá hạn",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _overdueFocusNode,
                nexFocusNode: _maxOverdueFocusNode,
                textInputAction: TextInputAction.next,
                labelText: 'Lãi suất quá hạn tối thiểu',
                hintText: "Nhập lãi suất quá hạn tối thiểu",
                controller: lendingOverdueInterestRateTextController,
                timeValue: timeValue,
                onChangeTimeValue: setTimeValue,
                validator: validateInterestRate,
              ),
              const SizedBox(height: 10),
              BaseRowTextDropdown(
                focusNode: _maxOverdueFocusNode,
                nexFocusNode: _maxOverdueFocusNode,
                textInputAction: TextInputAction.done,
                labelText: 'Lãi suất quá hạn tối đa',
                hintText: "Nhập lãi suất quá hạn tối đa",
                controller: lendingMaxOverdueInterestRateTextController,
                timeValue: timeValue,
                onChangeTimeValue: setTimeValue,
                validator: validateInterestRate,
              ),
              const SizedBox(height: 5),
              Text(
                "Hình ảnh",
                style: AppTextStyles.bold14.colorEx(Colors.black),
              ),
              const SizedBox(height: 10),
              PickerImages(),
            ],
          ),
        ),
      ),
    );
  }
}
