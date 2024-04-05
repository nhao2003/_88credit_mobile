part of 'account_bloc.dart';

enum SignoutStatus { initial, loading, success, failure }

enum GetAccountStatus { initial, loading, success, failure }

final class AccountState extends Equatable {
  final SignoutStatus signoutStatus;
  final GetAccountStatus getAccountStatus;
  final UserEntity user;
  final int servicePack;
  final bool isIdentity;

  const AccountState({
    this.signoutStatus = SignoutStatus.initial,
    this.getAccountStatus = GetAccountStatus.initial,
    this.user = const UserEntity(),
    this.servicePack = 0,
    this.isIdentity = false,
  });

  AccountState copyWith({
    SignoutStatus? signoutStatus,
    GetAccountStatus? getAccountStatus,
    UserEntity? user,
    int? servicePack,
    bool? isIdentity,
  }) {
    return AccountState(
      signoutStatus: signoutStatus ?? this.signoutStatus,
      getAccountStatus: getAccountStatus ?? this.getAccountStatus,
      user: user ?? this.user,
      servicePack: servicePack ?? this.servicePack,
      isIdentity: isIdentity ?? this.isIdentity,
    );
  }

  @override
  List<Object> get props => [
        signoutStatus,
        getAccountStatus,
        user,
        servicePack,
        isIdentity,
      ];
}
