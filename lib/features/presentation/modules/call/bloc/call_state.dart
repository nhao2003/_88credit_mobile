part of 'call_bloc.dart';

class CallState extends Equatable {
  final String callID;
  final UserInfo currentUser;

  const CallState({
    this.callID = '',
    this.currentUser = const UserInfo.empty(),
  });

  CallState copyWith({
    String? callID,
    UserInfo? currentUser,
  }) {
    return CallState(
      callID: callID ?? this.callID,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [
        callID,
        currentUser,
      ];
}

class UserInfo extends Equatable {
  final String id;
  final String name;
  const UserInfo({
    required this.name,
    required this.id,
  });

  bool get isEmpty => id.isEmpty;

  // UserInfo.empty();
  const UserInfo.empty()
      : id = '',
        name = '';

  @override
  List<Object> get props => [id, name];
}
