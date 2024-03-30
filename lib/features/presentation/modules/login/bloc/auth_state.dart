part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

final class AuthState extends Equatable {
  final AuthStatus status;
  final bool isShowPassword;

  const AuthState({
    this.status = AuthStatus.initial,
    this.isShowPassword = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isShowPassword,
  }) {
    return AuthState(
      status: status ?? this.status,
      isShowPassword: isShowPassword ?? this.isShowPassword,
    );
  }

  @override
  List<Object> get props => [status, isShowPassword];
}
