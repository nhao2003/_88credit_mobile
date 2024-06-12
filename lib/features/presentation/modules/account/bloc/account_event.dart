part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfile extends AccountEvent {}

class AccountGetUser extends AccountEvent {}

class SigoutEvent extends AccountEvent {}
