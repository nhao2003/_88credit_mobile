part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final String nameUser;
  final List<BlogEntity> blogs;
  final int unreadMessCount;
  final int unreadNotiCount;
  final int currentIndexTab;
  final int lendLimit;
  final int borrowLimit;
  final int lendedUsed;
  final int borrowedUsed;

  const HomeState({
    this.nameUser = "Minh Phan",
    this.blogs = const [],
    this.unreadMessCount = 1,
    this.unreadNotiCount = 1,
    this.currentIndexTab = 0,
    this.lendLimit = 20000000,
    this.borrowLimit = 10000000,
    this.lendedUsed = 100000,
    this.borrowedUsed = 5000000,
  });

  HomeState copyWith({
    String? nameUser,
    List<BlogEntity>? blogs,
    int? unreadMessCount,
    int? unreadNotiCount,
    int? currentIndexTab,
    int? lendLimit,
    int? borrowLimit,
    int? lendedUsed,
    int? borrowedUsed,
  }) {
    return HomeState(
      nameUser: nameUser ?? this.nameUser,
      blogs: blogs ?? this.blogs,
      unreadMessCount: unreadMessCount ?? this.unreadMessCount,
      unreadNotiCount: unreadNotiCount ?? this.unreadNotiCount,
      currentIndexTab: currentIndexTab ?? this.currentIndexTab,
      lendLimit: lendLimit ?? this.lendLimit,
      borrowLimit: borrowLimit ?? this.borrowLimit,
      lendedUsed: lendedUsed ?? this.lendedUsed,
      borrowedUsed: borrowedUsed ?? this.borrowedUsed,
    );
  }

  @override
  List<Object> get props => [
        nameUser,
        blogs,
        unreadMessCount,
        unreadNotiCount,
        currentIndexTab,
        lendLimit,
        borrowLimit,
        lendedUsed,
        borrowedUsed,
      ];
}
