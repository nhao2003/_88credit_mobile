import 'package:_88credit_mobile/core/errors/exceptions.dart';
import 'package:_88credit_mobile/features/domain/usecases/authentication/sign_out.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountEvent>((event, emit) {});
    on<AccountGetUser>(_onGetUser);
    on<SigoutEvent>(_onSignout);
  }

  Future _onGetUser(
    AccountGetUser event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(getAccountStatus: GetAccountStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      getAccountStatus: GetAccountStatus.success,
      user: user,
    ));
  }

  UserEntity get user => UserEntity(
        id: '1',
        status: UserStatus.verified,
        isIdentityVerified: true,
        role: Role.user,
        email: 'a@a.com',
        address: null,
        firstName: 'John',
        lastName: 'Doe',
        gender: true,
        avatar:
            'https://i.pinimg.com/736x/8a/6a/a8/8a6aa88d7b7efd82c7ddbf296dc401eb.jpg',
        dob: '1990-01-01',
        phone: '0123456789',
        lastActiveAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  Future _onSignout(
    SigoutEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(signoutStatus: SignoutStatus.loading));
    // await Future.delayed(const Duration(seconds: 2));
    final SignOutUseCase signOutUseCase = sl<SignOutUseCase>();
    try {
      final dataState = await signOutUseCase();
      if (dataState is DataSuccess) {
        return emit(state.copyWith(signoutStatus: SignoutStatus.success));
      }
      return emit(state.copyWith(
        signoutStatus: SignoutStatus.failure,
        signoutError: "Can't signout",
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        signoutStatus: SignoutStatus.failure,
        signoutError: e.message,
      ));
    }
  }
}
