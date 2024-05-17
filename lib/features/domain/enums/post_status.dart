// ignore_for_file: constant_identifier_names
enum PostStatus {
  PENDING,
  APPROVED,
  REJECTED,
  HIDED;

  static PostStatus parse(String value) {
    for (PostStatus status in PostStatus.values) {
      if (status.toString() == value) return status;
    }
    throw Exception("Can't parse PostStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case PostStatus.PENDING:
        return "PENDING";
      case PostStatus.APPROVED:
        return "APPROVED";
      case PostStatus.REJECTED:
        return "REJECTED";
      case PostStatus.HIDED:
        return "HIDED";
    }
  }
}
