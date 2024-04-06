part of 'create_post_bloc.dart';

enum CreatePostStatus { initial, loading, success, failure }

final class CreatePostState extends Equatable {
  final bool isLending;
  final CreatePostStatus status;
  final bool photoController;
  final List<File> photo;
  final List<String> imageUrlList;
  const CreatePostState({
    this.isLending = false,
    this.status = CreatePostStatus.initial,
    this.photoController = true,
    this.photo = const [],
    this.imageUrlList = const [],
  });

  CreatePostState copyWith({
    bool? isLending,
    CreatePostStatus? status,
    bool? photoController,
    List<File>? photo,
    List<String>? imageUrlList,
  }) {
    return CreatePostState(
      isLending: isLending ?? this.isLending,
      status: status ?? this.status,
      photoController: photoController ?? this.photoController,
      photo: photo ?? this.photo,
      imageUrlList: imageUrlList ?? this.imageUrlList,
    );
  }

  @override
  List<Object> get props => [
        isLending,
        status,
        photoController,
        photo,
        imageUrlList,
      ];
}
