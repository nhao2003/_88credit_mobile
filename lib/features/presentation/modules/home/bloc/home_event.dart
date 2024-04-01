part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchBlogs extends HomeEvent {}

final class ChangeTabEvent extends HomeEvent {
  final int index;

  const ChangeTabEvent({required this.index});

  @override
  List<Object> get props => [index];
}
