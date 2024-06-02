// ignore_for_file: constant_identifier_names
enum LoanContractRequestStatus {
  pending,
  approved,
  cancelled,
  rejected,
  paid;

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
      case LoanContractRequestStatus.approved:
        return "approved";
      case LoanContractRequestStatus.cancelled:
        return "cancelled";
      case LoanContractRequestStatus.pending:
        return "pending";
      case LoanContractRequestStatus.rejected:
        return "rejected";
      case LoanContractRequestStatus.paid:
        return "paid";
    }
  }

  String getStringVi() {
    switch (this) {
      case LoanContractRequestStatus.approved:
        return "Đã xác nhận";
      case LoanContractRequestStatus.cancelled:
        return "Đã hủy";
      case LoanContractRequestStatus.pending:
        return "Đang chờ";
      case LoanContractRequestStatus.rejected:
        return "Đã từ chối";
      case LoanContractRequestStatus.paid:
        return "Đã thanh toán";
    }
  }

  // toMap
  static Map<LoanContractRequestStatus, String> toMap() {
    return {
      LoanContractRequestStatus.approved: "Đã xác nhận",
      LoanContractRequestStatus.cancelled: "Đã hủy",
      LoanContractRequestStatus.pending: "Đang chờ",
      LoanContractRequestStatus.rejected: "Đã từ chối",
      LoanContractRequestStatus.paid: "Đã thanh toán",
    };
  }
}
