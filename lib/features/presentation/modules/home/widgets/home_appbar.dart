import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../config/values/asset_image.dart';
import '../../../../../../../core/utils/check_time_date.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/home_bloc.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  Greeting getGreeting() {
    return CheckTimeOfDate.getGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            // Sun
            Image.asset(
              getGreeting() == Greeting.evening ? Assets.solar : Assets.sun,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 2),
            // Hello text
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Text(
                  getGreeting() == Greeting.evening
                      ? 'Chào buổi tối, ${state.nameUser}!'
                      : getGreeting() == Greeting.afternoon
                          ? 'Chào buổi chiều, ${state.nameUser}!'
                          : 'Chào buổi sáng, ${state.nameUser}!',
                  style: AppTextStyles.bold14.colorEx(
                    AppColors.green,
                  ),
                );
              },
            ),
          ],
        ),
        // Icons
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              children: [
                state.unreadMessCount == 0
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(AppRoutes.loginCall);
                          Navigator.of(context).pushNamed(AppRoutes.chat);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Image.asset(Assets.chat, width: 25),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.chat);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: badges.Badge(
                            position: badges.BadgePosition.topStart(
                                top: -8, start: 18),
                            badgeContent: Text(
                              state.unreadMessCount.toString(),
                              style:
                                  AppTextStyles.bold10.colorEx(AppColors.white),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: AppColors.green,
                            ),
                            child: Image.asset(Assets.chat, width: 25),
                          ),
                        ),
                      ),
                state.unreadNotiCount == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.notifications);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Image.asset(Assets.notification, width: 25),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.notifications);
                          },
                          child: badges.Badge(
                            position: badges.BadgePosition.topStart(
                                top: -8, start: 18),
                            badgeContent: Text(
                              state.unreadNotiCount.toString(),
                              style:
                                  AppTextStyles.bold10.colorEx(AppColors.white),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: AppColors.green,
                            ),
                            child: Image.asset(Assets.notification, width: 25),
                          ),
                        ),
                      ),
              ],
            );
          },
        )
      ],
    );
  }
}
