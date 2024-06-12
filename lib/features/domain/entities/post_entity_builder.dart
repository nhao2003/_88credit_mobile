import '../enums/loan_reason_types.dart';
import '../enums/post_status.dart';
import '../enums/post_type.dart';
import 'post.dart';
import 'user.dart';

abstract class IPostEntityBuilder {
  IPostEntityBuilder setId(String? id);
  IPostEntityBuilder setUserId(String? userId);
  IPostEntityBuilder setUser(UserEntity? user);
  IPostEntityBuilder setStatus(PostStatus? status);
  IPostEntityBuilder setLoanReason(LoanReasonTypes? loanReason);
  IPostEntityBuilder setLoanReasonDescription(String? loanReasonDescription);
  IPostEntityBuilder setType(PostTypes? type);
  IPostEntityBuilder setTitle(String? title);
  IPostEntityBuilder setDescription(String? description);
  IPostEntityBuilder setImages(List<String>? images);
  IPostEntityBuilder setInterestRate(double? interestRate);
  IPostEntityBuilder setAmount(double? amount);
  IPostEntityBuilder setDuration(int? duration);
  IPostEntityBuilder setOverdueInterestRate(double? overdueInterestRate);
  IPostEntityBuilder setMaxInterestRate(double? maxInterestRate);
  IPostEntityBuilder setMaxAmount(double? maxAmount);
  IPostEntityBuilder setMaxDuration(int? maxDuration);
  IPostEntityBuilder setMaxOverdueInterestRate(double? maxOverdueInterestRate);
  IPostEntityBuilder setRejectionReason(String? rejectionReason);
  IPostEntityBuilder setCreatedAt(DateTime? createdAt);
  IPostEntityBuilder setUpdatedAt(DateTime? updatedAt);
  PostEntity build();
}

class PostEntityBuilder implements IPostEntityBuilder {
  String? _id;
  String? _userId;
  UserEntity? _user;
  PostStatus? _status;
  LoanReasonTypes? _loanReason;
  String? _loanReasonDescription;
  PostTypes? _type;
  String? _title;
  String? _description;
  List<String>? _images;
  double? _interestRate;
  double? _amount;
  int? _duration;
  double? _overdueInterestRate;
  double? _maxInterestRate;
  double? _maxAmount;
  int? _maxDuration;
  double? _maxOverdueInterestRate;
  String? _rejectionReason;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  PostEntityBuilder();

  @override
  PostEntityBuilder setId(String? id) {
    _id = id;
    return this;
  }
  @override
  PostEntityBuilder setUserId(String? userId) {
    _userId = userId;
    return this;
  }
  @override
  PostEntityBuilder setUser(UserEntity? user) {
    _user = user;
    return this;
  }
  @override
  PostEntityBuilder setStatus(PostStatus? status) {
    _status = status;
    return this;
  }
  @override
  PostEntityBuilder setLoanReason(LoanReasonTypes? loanReason) {
    _loanReason = loanReason;
    return this;
  }
  @override
  PostEntityBuilder setLoanReasonDescription(String? loanReasonDescription) {
    _loanReasonDescription = loanReasonDescription;
    return this;
  }
  @override
  PostEntityBuilder setType(PostTypes? type) {
    _type = type;
    return this;
  }
  @override
  PostEntityBuilder setTitle(String? title) {
    _title = title;
    return this;
  }
  @override
  PostEntityBuilder setDescription(String? description) {
    _description = description;
    return this;
  }
  @override
  PostEntityBuilder setImages(List<String>? images) {
    _images = images;
    return this;
  }
  @override
  PostEntityBuilder setInterestRate(double? interestRate) {
    _interestRate = interestRate;
    return this;
  }
  @override
  PostEntityBuilder setAmount(double? amount) {
    _amount = amount;
    return this;
  }
  @override
  PostEntityBuilder setDuration(int? duration) {
    _duration = duration;
    return this;
  }
  @override
  PostEntityBuilder setOverdueInterestRate(double? overdueInterestRate) {
    _overdueInterestRate = overdueInterestRate;
    return this;
  }
  @override
  PostEntityBuilder setMaxInterestRate(double? maxInterestRate) {
    _maxInterestRate = maxInterestRate;
    return this;
  }
  @override
  PostEntityBuilder setMaxAmount(double? maxAmount) {
    _maxAmount = maxAmount;
    return this;
  }
  @override
  PostEntityBuilder setMaxDuration(int? maxDuration) {
    _maxDuration = maxDuration;
    return this;
  }
  @override
  PostEntityBuilder setMaxOverdueInterestRate(double? maxOverdueInterestRate) {
    _maxOverdueInterestRate = maxOverdueInterestRate;
    return this;
  }
  @override
  PostEntityBuilder setRejectionReason(String? rejectionReason) {
    _rejectionReason = rejectionReason;
    return this;
  }
  @override
  PostEntityBuilder setCreatedAt(DateTime? createdAt) {
    _createdAt = createdAt;
    return this;
  }
  @override
  PostEntityBuilder setUpdatedAt(DateTime? updatedAt) {
    _updatedAt = updatedAt;
    return this;
  }
  @override
  PostEntity build() {
    return PostEntity(
      id: _id,
      userId: _userId,
      user: _user,
      status: _status,
      loanReason: _loanReason,
      loanReasonDescription: _loanReasonDescription,
      type: _type,
      title: _title,
      description: _description,
      images: _images,
      interestRate: _interestRate,
      amount: _amount,
      duration: _duration,
      overdueInterestRate: _overdueInterestRate,
      maxInterestRate: _maxInterestRate,
      maxAmount: _maxAmount,
      maxDuration: _maxDuration,
      maxOverdueInterestRate: _maxOverdueInterestRate,
      rejectionReason: _rejectionReason,
      createdAt: _createdAt,
      updatedAt: _updatedAt,
    );
  }
}



