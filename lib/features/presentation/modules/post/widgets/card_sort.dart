import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/values/asset_image.dart';
import '../bloc/post_bloc.dart';

enum TypeSort {
  latest,
  amountIncrease,
  amountDecrease,
  rateIncrease,
  rateDecrease
}

class CardSort extends StatefulWidget {
  const CardSort({super.key});

  @override
  State<CardSort> createState() => _CardSortState();
}

class _CardSortState extends State<CardSort> {
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 600,
          width: double.infinity,
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Xắp xếp',
                      style: AppTextStyles.bold16,
                    ),
                  ),
                  buildCard(
                    'Thời gian',
                    'Mới nhất',
                    Assets.clock,
                    TypeSort.latest,
                    state.typeSort,
                  ),
                  buildCard(
                    'Số tiền',
                    'Tăng dần',
                    Assets.circleUp,
                    TypeSort.amountIncrease,
                    state.typeSort,
                  ),
                  buildCard(
                    'Số tiền',
                    'Giảm dần',
                    Assets.circleDown,
                    TypeSort.amountDecrease,
                    state.typeSort,
                  ),
                  buildCard(
                    'Lãi suất',
                    'Tăng dần',
                    Assets.trendUp,
                    TypeSort.rateIncrease,
                    state.typeSort,
                  ),
                  buildCard(
                    'Lãi suất',
                    'Giảm dần',
                    Assets.trenDown,
                    TypeSort.rateDecrease,
                    state.typeSort,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget buildCard(String title, String description, String icon,
      TypeSort value, TypeSort typeSort) {
    return InkWell(
      onTap: () {
        context.read<PostBloc>().add(ChangeSortType(value));
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColors.grey200,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  icon,
                  height: 35,
                  width: 35,
                  color: AppColors.black,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bold16,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: AppTextStyles.regular12,
                    ),
                  ],
                ),
              ],
            ),
            Radio(
              value: value,
              groupValue: typeSort,
              fillColor: MaterialStateProperty.all(AppColors.green),
              onChanged: (TypeSort? value) {
                context.read<PostBloc>().add(ChangeSortType(value!));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return Text(
                  state.typeSort == TypeSort.latest
                      ? 'Mới nhất'
                      : state.typeSort == TypeSort.amountIncrease
                          ? 'Tiền tăng dần'
                          : state.typeSort == TypeSort.amountDecrease
                              ? 'Tiền giảm dần'
                              : state.typeSort == TypeSort.rateIncrease
                                  ? 'Lãi suất tăng dần'
                                  : 'Lãi suất giảm dần',
                  style: AppTextStyles.bold14,
                );
              },
            ),
            Image.asset(
              Assets.slider,
              height: 25,
              width: 25,
            )
          ],
        ),
      ),
    );
  }
}
