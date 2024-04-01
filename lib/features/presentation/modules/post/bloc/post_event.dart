part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class GetLendingPostEnvent extends PostEvent {}

final class GetBorrowingPostEnvent extends PostEvent {}

final class RefreshPostEnvent extends PostEvent {}

final class FetchMorePostEnvent extends PostEvent {}
