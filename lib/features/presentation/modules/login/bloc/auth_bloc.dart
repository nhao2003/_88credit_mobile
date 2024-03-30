import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEvent>((event, emit) => emit(state.copyWith(
          status: AuthStatus.loading,
        )));
    on<AuthIsLoggedIn>(_isLoggedIn);
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignup>(_onAuthSignup);
    on<TogglePasswordVisibility>(togglePasswordVisibility);
  }

  void _isLoggedIn(
    AuthIsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }

  void _onAuthSignup(
    AuthSignup event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }

  void togglePasswordVisibility(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) {
    print(state.isShowPassword);
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }
}
