import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_color.dart';
import '../bloc/home_bloc.dart';

class MyTabbar extends StatefulWidget {
  const MyTabbar({super.key});

  @override
  State<MyTabbar> createState() => _MyTabbarState();
}

class _MyTabbarState extends State<MyTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  _handleTabSelection() {
    BlocProvider.of<HomeBloc>(context).add(
      ChangeTabEvent(index: _tabController.index),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          width: 1,
          color: AppColors.grey200,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        // give the indicator a decoration (color and border radius)
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          color: AppColors.green,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.green,
        padding: const EdgeInsets.all(0),
        indicatorWeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(0),
        tabs: [
          // first tab [you can add an icon using the icon property]
          SizedBox(
            width: 100.wp,
            child: const Tab(
              text: 'Vay tiền',
            ),
          ),

          // second tab [you can add an icon using the icon property]
          SizedBox(
            width: 100.wp,
            child: const Tab(
              text: 'Cho vay',
            ),
          ),
        ],
      ),
    );
  }
}
