part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class RefreshPostEnvent extends PostEvent {
  final PostTypes postType;

  const RefreshPostEnvent(this.postType);

  @override
  List<Object> get props => [postType];
}

final class FetchMorePostEnvent extends PostEvent {
  final PostTypes postType;

  const FetchMorePostEnvent(this.postType);

  @override
  List<Object> get props => [postType];
}

final class ChangeSortType extends PostEvent {
  final TypeSort typeSort;

  const ChangeSortType(this.typeSort);

  @override
  List<Object> get props => [typeSort];
}
