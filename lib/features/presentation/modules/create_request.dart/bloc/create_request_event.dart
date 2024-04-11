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
