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

class SendPostEvent extends CreatePostEvent {
  final String title;
  final String description;

  const SendPostEvent(this.title, this.description);

  @override
  List<Object> get props => [title, description];
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
