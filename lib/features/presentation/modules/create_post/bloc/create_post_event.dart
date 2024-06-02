part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class TogglePageEvent extends CreatePostEvent {
  final PostTypes postType;

  const TogglePageEvent(this.postType);

  @override
  List<Object> get props => [postType];
}

class SendPostEvent extends CreatePostEvent {
  final String? title;
  final String? description;
  final double? amount;
  final double? maxAmount;
  final double? interestRate;
  final double? maxInterestRate;
  final int? duration;
  final int? maxDuration;
  final double? overdueInterestRate;
  final double? maxOverdueInterestRate;
  final String? loanReasonDescription;

  const SendPostEvent({
    this.title,
    this.description,
    this.amount,
    this.maxAmount,
    this.interestRate,
    this.maxInterestRate,
    this.duration,
    this.maxDuration,
    this.overdueInterestRate,
    this.maxOverdueInterestRate,
    this.loanReasonDescription,
  });

  @override
  List<Object> get props => [
        title!,
        description!,
        amount!,
        maxAmount!,
        interestRate!,
        maxInterestRate!,
        duration!,
        maxDuration!,
        overdueInterestRate!,
        maxOverdueInterestRate!,
        loanReasonDescription!,
      ];
}

class AddFileImageEvent extends CreatePostEvent {
  final File file;

  const AddFileImageEvent(this.file);

  @override
  List<Object> get props => [file];
}

class RemoveFileImageEvent extends CreatePostEvent {
  final int index;

  const RemoveFileImageEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CheckLengthPhoto extends CreatePostEvent {}

class ChangeLoanReasonEvent extends CreatePostEvent {
  final LoanReasonTypes loanReason;

  const ChangeLoanReasonEvent(this.loanReason);

  @override
  List<Object> get props => [loanReason];
}
