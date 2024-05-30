import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/values/asset_image.dart';
import '../account/screens/account_screen.dart';
import '../request/screens/contract_screen.dart';
import '../home/screens/home_screen.dart';
import '../post/screens/post_screen.dart';
import 'bloc/bar_bloc.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Widget> _pages = [];
  List<TabItem<dynamic>> _tab = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeScreen(),
      const PostScreen(),
      const Scaffold(),
      const RequestScreen(),
      const AccountScreen(),
    ];

    _tab = [
      TabItem(
        icon: Image.asset(Assets.home, color: AppColors.grey700),
        activeIcon: Image.asset(Assets.home, color: AppColors.green),
        title: "Trang chủ",
      ),
      TabItem(
        icon: Image.asset(Assets.chart, color: AppColors.grey700),
        activeIcon: Image.asset(Assets.chart, color: AppColors.green),
        title: 'Bài đăng',
      ),
      TabItem(
        icon: CircleAvatar(
          backgroundColor: AppColors.green,
          child: Image.asset(
            Assets.pencil,
            width: 40,
          ),
        ),
      ),
      TabItem(
        icon: Image.asset(Assets.clipboard, color: AppColors.grey700),
        activeIcon: Image.asset(Assets.clipboard, color: AppColors.green),
        title: 'Hợp đồng',
      ),
      TabItem(
        icon: Image.asset(Assets.user),
        activeIcon: Image.asset(Assets.user, color: AppColors.green),
        title: 'Tài khoản',
      ),
    ];
    tabController = TabController(length: _tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarBloc, BarState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: _pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: (index) {
              if (index == 2) {
                Navigator.of(context).pushNamed(AppRoutes.createPost);
              } else {
                context.read<BarBloc>().add(BarChangeTab(index));
                tabController.index = state.index;
              }
            },
            backgroundColor: AppColors.white,
            color: AppColors.black,
            activeColor: AppColors.green,
            style: TabStyle.fixedCircle,
            curveSize: 75,
            top: -22,
            height: 55,
            items: _tab,
          ),
        );
      },
    );
  }
}
