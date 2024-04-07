part of 'create_post_bloc.dart';

enum CreatePostStatus { initial, loading, success, failure }

final class CreatePostState extends Equatable {
  final bool isLending;
  final CreatePostStatus status;
  final bool photoController;
  final List<File> photo;
  final List<String> imageUrlList;
  final LoanReasonTypes loanReasonType;

  const CreatePostState({
    this.isLending = false,
    this.status = CreatePostStatus.initial,
    this.photoController = true,
    this.photo = const [],
    this.imageUrlList = const [],
    this.loanReasonType = LoanReasonTypes.other,
  });

  CreatePostState copyWith({
    bool? isLending,
    CreatePostStatus? status,
    bool? photoController,
    List<File>? photo,
    List<String>? imageUrlList,
    LoanReasonTypes? loanReasonType,
  }) {
    return CreatePostState(
      isLending: isLending ?? this.isLending,
      status: status ?? this.status,
      photoController: photoController ?? this.photoController,
      photo: photo ?? this.photo,
      imageUrlList: imageUrlList ?? this.imageUrlList,
      loanReasonType: loanReasonType ?? this.loanReasonType,
    );
  }

  @override
  List<Object> get props => [
        isLending,
        status,
        photoController,
        photo,
        imageUrlList,
        loanReasonType,
      ];
}
