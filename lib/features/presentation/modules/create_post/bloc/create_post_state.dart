part of 'create_post_bloc.dart';

enum CreatePostStatus { initial, loading, success, failure }

final class CreatePostState extends Equatable {
  final bool isLending;
  final CreatePostStatus status;
  const CreatePostState({
    this.isLending = false,
    this.status = CreatePostStatus.initial,
  });

  CreatePostState copyWith({
    bool? isLending,
    CreatePostStatus? status,
  }) {
    return CreatePostState(
      isLending: isLending ?? this.isLending,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        isLending,
        status,
      ];
}
