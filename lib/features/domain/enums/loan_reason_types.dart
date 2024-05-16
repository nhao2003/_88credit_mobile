// [ BUSINESS, EDUCATION, TRAVEL, WEDDING, MEDICAL, SHOPPING, HOUSE_BUYING, CAR_BUYING, OTHER ]
enum LoanReasonTypes {
  BUSINESS,
  EDUCATION,
  TRAVEL,
  WEDDING,
  MEDICAL,
  SHOPPING,
  HOUSE_BUYING,
  CAR_BUYING,
  OTHER;

  //parse
  static LoanReasonTypes parse(String value) {
    for (LoanReasonTypes type in LoanReasonTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse LoanReasonTypes! Your input value is \"$value\"");
  }

  //toString
  @override
  String toString() {
    switch (this) {
      case LoanReasonTypes.BUSINESS:
        return "BUSINESS";
      case LoanReasonTypes.EDUCATION:
        return "EDUCATION";
      case LoanReasonTypes.TRAVEL:
        return "TRAVEL";
      case LoanReasonTypes.WEDDING:
        return "WEDDING";
      case LoanReasonTypes.MEDICAL:
        return "MEDICAL";
      case LoanReasonTypes.SHOPPING:
        return "SHOPPING";
      case LoanReasonTypes.HOUSE_BUYING:
        return "HOUSE_BUYING";
      case LoanReasonTypes.CAR_BUYING:
        return "CAR_BUYING";
      case LoanReasonTypes.OTHER:
        return "OTHER";
    }
  }

  //getStringVi
  String toStringVi() {
    switch (this) {
      case LoanReasonTypes.BUSINESS:
        return "Kinh doanh";
      case LoanReasonTypes.EDUCATION:
        return "Học tập";
      case LoanReasonTypes.TRAVEL:
        return "Du lịch";
      case LoanReasonTypes.WEDDING:
        return "Cưới hỏi";
      case LoanReasonTypes.MEDICAL:
        return "Y tế";
      case LoanReasonTypes.SHOPPING:
        return "Mua sắm";
      case LoanReasonTypes.HOUSE_BUYING:
        return "Mua nhà";
      case LoanReasonTypes.CAR_BUYING:
        return "Mua ô tô";
      case LoanReasonTypes.OTHER:
        return "Khác";
    }
  }

  //toMap
  static Map<LoanReasonTypes, String> toMap() {
    return {
      LoanReasonTypes.BUSINESS: "Kinh doanh",
      LoanReasonTypes.EDUCATION: "Học tập",
      LoanReasonTypes.TRAVEL: "Du lịch",
      LoanReasonTypes.WEDDING: "Cưới hỏi",
      LoanReasonTypes.MEDICAL: "Y tế",
      LoanReasonTypes.SHOPPING: "Mua sắm",
      LoanReasonTypes.HOUSE_BUYING: "Mua nhà",
      LoanReasonTypes.CAR_BUYING: "Mua ô tô",
      LoanReasonTypes.OTHER: "Khác",
    };
  }
}
