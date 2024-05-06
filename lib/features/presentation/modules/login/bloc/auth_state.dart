part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

final class AuthState extends Equatable {
  final AuthStatus status;
  final bool isShowPassword;
  final bool isShowComfirmPassword;
  final String failureMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.isShowPassword = true,
    this.isShowComfirmPassword = true,
    this.failureMessage = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isShowPassword,
    bool? isShowComfirmPassword,
    String? failureMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isShowComfirmPassword:
          isShowComfirmPassword ?? this.isShowComfirmPassword,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        isShowPassword,
        isShowComfirmPassword,
        failureMessage,
      ];
}
