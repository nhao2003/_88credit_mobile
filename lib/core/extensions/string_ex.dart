import 'package:_88credit_mobile/core/utils/validate_utils.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';

extension StringX on String {
  /// Viết hoa chữ cái đầu
  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return this;
  }

  double removeTrailingZerosAndNumberfy(String n) {
    if (n.contains('.')) {
      return double.parse(n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"),
              "") //remove all trailing 0's and extra decimals at end if any
          );
    } else {
      return double.parse(n);
    }
  }

  /// Parse string sang double (trả về default value thay vì throw lỗi)
  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }

  /// check string is number
  bool isNumeric() {
    if (this == "") {
      return false;
    }
    return double.tryParse(this) != null;
  }

  String noAccentVietnamese() {
    String s = this;
    s = s.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    s = s.replaceAll(RegExp(r'[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]'), 'A');
    s = s.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    s = s.replaceAll(RegExp(r'[ÈÉẸẺẼÊỀẾỆỂỄ]'), 'E');
    s = s.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    s = s.replaceAll(RegExp(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]'), 'O');
    s = s.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    s = s.replaceAll(RegExp(r'[ÌÍỊỈĨ]'), 'I');
    s = s.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    s = s.replaceAll(RegExp(r'[ƯỪỨỰỬỮÙÚỤỦŨ]'), 'U');
    s = s.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    s = s.replaceAll(RegExp(r'[ỲÝỴỶỸ]'), 'Y');
    s = s.replaceAll(RegExp(r'[Đ]'), 'D');
    s = s.replaceAll(RegExp(r'[đ]'), 'd');
    return s;
  }

  bool get isEmail => ValidateUtils.isEmail(this);

  bool get isPhoneNumber => ValidateUtils.isPhoneNumber(this);

  bool get isURL => ValidateUtils.isURL(this);

  bool get isUsername => ValidateUtils.isUsername(this);

  bool get isDateTime => ValidateUtils.isDateTime(this);
}

class ValidateString implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Ít nhất - ký tự';
  @override
  final String uppercaseLetters = '- Ký tự viết hoa';
  @override
  final String numericCharacters = '- Ký tự số';
  @override
  final String specialCharacters = '- Ký tự đặt biệt';
  @override
  final String lowercaseLetters = '- Ký tự viết thường';

  @override
  final String normalLetters = '- Ký tự thường';
}
