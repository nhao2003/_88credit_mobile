part of 'create_request_bloc.dart';

sealed class CreateRequestEvent extends Equatable {
  const CreateRequestEvent();

  @override
  List<Object> get props => [];
}

class ChangeReceiver extends CreateRequestEvent {
  final UserEntity receiver;

  const ChangeReceiver(this.receiver);

  @override
  List<Object> get props => [receiver];
}

class GetPrimaryBankCard extends CreateRequestEvent {
  const GetPrimaryBankCard();
}

class PostRequest extends CreateRequestEvent {}

class ChangePortrait extends CreateRequestEvent {
  final File portrait;

  const ChangePortrait(this.portrait);

  @override
  List<Object> get props => [portrait];
}

class ChangeIdCardFrontPhoto extends CreateRequestEvent {
  final File idCardFrontPhoto;

  const ChangeIdCardFrontPhoto(this.idCardFrontPhoto);

  @override
  List<Object> get props => [idCardFrontPhoto];
}

class ChangeIdCardBackPhoto extends CreateRequestEvent {
  final File idCardBackPhoto;

  const ChangeIdCardBackPhoto(this.idCardBackPhoto);

  @override
  List<Object> get props => [idCardBackPhoto];
}

class ChangeVideo extends CreateRequestEvent {
  final File video;

  const ChangeVideo(this.video);

  @override
  List<Object> get props => [video];
}
