part of 'call_bloc.dart';

sealed class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class ChangeUser extends CallEvent {
  final String id;
  final String name;

  const ChangeUser({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

class ChangeCallID extends CallEvent {
  final String callID;

  const ChangeCallID({
    required this.callID,
  });

  @override
  List<Object> get props => [callID];
}
