import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/usecases/authentication/sign_in.dart';
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
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_toggleConfirmPasswordVisibility);
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
    try {
      final SignInUseCase signInUseCase = sl<SignInUseCase>();
      Map<String, dynamic>? params = {
        "email": event.email,
        "password": event.password,
      };

      final dataState = await signInUseCase(params: params);

      if (dataState is DataSuccess) {
        return emit(state.copyWith(status: AuthStatus.success));
      }
      return emit(state.copyWith(
        status: AuthStatus.failure,
        failureMessage: "Can't login",
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        failureMessage: e.toString(),
      ));
    }
  }

  void _onAuthSignup(
    AuthSignup event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AuthStatus.success));
  }

  void _togglePasswordVisibility(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }

  void _toggleConfirmPasswordVisibility(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isShowComfirmPassword: !state.isShowComfirmPassword));
  }
}
