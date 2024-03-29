part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class AuthSignup extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthSignup(this.email, this.password, this.confirmPassword);

  @override
  List<Object> get props => [email, password, confirmPassword];
}

final class AuthIsLoggedIn extends AuthEvent {}
