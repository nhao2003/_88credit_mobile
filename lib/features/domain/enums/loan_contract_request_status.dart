// ignore_for_file: constant_identifier_names
enum LoanContractRequestStatus {
  CANCLE,
  PENDING,
  REJECTED,
  WAITING_FOR_PAYMENT,
  PAID;

  static LoanContractRequestStatus parse(String value) {
    for (LoanContractRequestStatus status in LoanContractRequestStatus.values) {
      if (status.toString() == value) return status;
    }
    throw Exception(
        "Can't parse LoanContractRequestStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case LoanContractRequestStatus.CANCLE:
        return "CANCLE";
      case LoanContractRequestStatus.PENDING:
        return "PENDING";
      case LoanContractRequestStatus.REJECTED:
        return "REJECTED";
      case LoanContractRequestStatus.WAITING_FOR_PAYMENT:
        return "WAITING_FOR_PAYMENT";
      case LoanContractRequestStatus.PAID:
        return "PAID";
    }
  }

  String getStringVi() {
    switch (this) {
      case LoanContractRequestStatus.CANCLE:
        return "Đã xác nhận";
      case LoanContractRequestStatus.PENDING:
        return "Đang chờ";
      case LoanContractRequestStatus.REJECTED:
        return "Đã từ chối";
      case LoanContractRequestStatus.WAITING_FOR_PAYMENT:
        return "Đang chờ thanh toán";
      case LoanContractRequestStatus.PAID:
        return "Đã thanh toán";
    }
  }

  // toMap
  static Map<LoanContractRequestStatus, String> toMap() {
    return {
      LoanContractRequestStatus.CANCLE: "Đã hủy",
      LoanContractRequestStatus.PENDING: "Đang chờ",
      LoanContractRequestStatus.REJECTED: "Đã từ chối",
      LoanContractRequestStatus.WAITING_FOR_PAYMENT: "Đang chờ thanh toán",
      LoanContractRequestStatus.PAID: "Đã thanh toán",
    };
  }
}
