part of 'home_bloc.dart';

enum BlogStatus { initial, success, failure }

final class HomeState extends Equatable {
  final BlogStatus status;
  final String nameUser;
  final List<BlogEntity> blogs;
  final int unreadMessCount;
  final int unreadNotiCount;
  final int currentIndexTab;
  final int lendLimit;
  final int borrowLimit;
  final int lendedUsed;
  final int borrowedUsed;
  final List<AdvertisementEnity> listAds;

  const HomeState({
    this.status = BlogStatus.initial,
    this.nameUser = "Minh Phan",
    this.blogs = const [],
    this.unreadMessCount = 1,
    this.unreadNotiCount = 1,
    this.currentIndexTab = 0,
    this.lendLimit = 20000000,
    this.borrowLimit = 10000000,
    this.lendedUsed = 100000,
    this.borrowedUsed = 5000000,
    this.listAds = listInitAds,
  });

  HomeState copyWith({
    BlogStatus? status,
    String? nameUser,
    List<BlogEntity>? blogs,
    int? unreadMessCount,
    int? unreadNotiCount,
    int? currentIndexTab,
    int? lendLimit,
    int? borrowLimit,
    int? lendedUsed,
    int? borrowedUsed,
    List<AdvertisementEnity>? listAds,
  }) {
    return HomeState(
      status: status ?? this.status,
      nameUser: nameUser ?? this.nameUser,
      blogs: blogs ?? this.blogs,
      unreadMessCount: unreadMessCount ?? this.unreadMessCount,
      unreadNotiCount: unreadNotiCount ?? this.unreadNotiCount,
      currentIndexTab: currentIndexTab ?? this.currentIndexTab,
      lendLimit: lendLimit ?? this.lendLimit,
      borrowLimit: borrowLimit ?? this.borrowLimit,
      lendedUsed: lendedUsed ?? this.lendedUsed,
      borrowedUsed: borrowedUsed ?? this.borrowedUsed,
      listAds: listAds ?? this.listAds,
    );
  }

  @override
  List<Object> get props => [
        status,
        nameUser,
        blogs,
        unreadMessCount,
        unreadNotiCount,
        currentIndexTab,
        lendLimit,
        borrowLimit,
        lendedUsed,
        borrowedUsed,
        listAds,
      ];
}

const List<AdvertisementEnity> listInitAds = [
  AdvertisementEnity(
    id: '1',
    thumbnail:
        'https://tinnhiemmang.vn/storage/photos/shares/tin-tuc/tt2022/10211a.jpg',
    link: 'https://flutter.dev',
  ),
  AdvertisementEnity(
    id: '2',
    thumbnail:
        'https://cdn.tima.vn/content-image/2020/4/2020440_vay-40tr-khong-the-chap.jpg',
    link: 'https://flutter.dev',
  ),
  AdvertisementEnity(
    id: '3',
    thumbnail:
        'https://cdn.tuoitre.vn/471584752817336320/2023/9/20/photo-1695177142803-16951771434652004020101.jpg',
    link: 'https://flutter.dev',
  ),
  AdvertisementEnity(
    id: '4',
    thumbnail:
        'https://image.congan.com.vn/thumbnail/CATP-480-2023-4-28/nhung-app-vay-tien-bi-bat-1_637_382_326.jpg',
    link: 'https://flutter.dev',
  ),
  AdvertisementEnity(
    id: '5',
    thumbnail:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1em0CudPUva4SQdZ522Qx6UA6jsDed5OA0w&usqp=CAU',
    link: 'https://flutter.dev',
  ),
];
