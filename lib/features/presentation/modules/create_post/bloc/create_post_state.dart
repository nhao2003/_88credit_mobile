part of 'create_post_bloc.dart';

enum CreatePostStatus { initial, loading, success, failure }

final class CreatePostState extends Equatable {
  final PostTypes postType;
  final CreatePostStatus status;
  final bool photoController;
  final List<File> photo;
  final List<String> imageUrlList;
  final LoanReasonTypes loanReasonType;
  final String failureString;

  const CreatePostState({
    this.postType = PostTypes.borrowing,
    this.status = CreatePostStatus.initial,
    this.photoController = true,
    this.photo = const [],
    this.imageUrlList = const [],
    this.loanReasonType = LoanReasonTypes.business,
    this.failureString = '',
  });

  CreatePostState copyWith({
    PostTypes? postType,
    CreatePostStatus? status,
    bool? photoController,
    List<File>? photo,
    List<String>? imageUrlList,
    LoanReasonTypes? loanReasonType,
    String? failureString,
  }) {
    return CreatePostState(
      postType: postType ?? this.postType,
      status: status ?? this.status,
      photoController: photoController ?? this.photoController,
      photo: photo ?? this.photo,
      imageUrlList: imageUrlList ?? this.imageUrlList,
      loanReasonType: loanReasonType ?? this.loanReasonType,
      failureString: failureString ?? this.failureString,
    );
  }

  @override
  List<Object> get props => [
        postType,
        status,
        photoController,
        photo,
        imageUrlList,
        loanReasonType,
        failureString,
      ];
}
