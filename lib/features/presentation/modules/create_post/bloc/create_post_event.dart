part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class TogglePageEvent extends CreatePostEvent {
  final bool isLending;

  const TogglePageEvent(this.isLending);

  @override
  List<Object> get props => [isLending];
}

class SendPostEvent extends CreatePostEvent {}
