import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/create_post_bloc.dart';

class ChooseLendingCard extends StatelessWidget {
  const ChooseLendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostBloc, CreatePostState>(
      builder: (context, state) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                context
                    .read<CreatePostBloc>()
                    .add(const TogglePageEvent(false));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: state.isLending != true
                      ? AppColors.greenLight
                      : AppColors.grey200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Vay tiền",
                  style: AppTextStyles.medium14.copyWith(
                    color: state.isLending != true
                        ? AppColors.green
                        : AppColors.grey600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                context.read<CreatePostBloc>().add(const TogglePageEvent(true));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: state.isLending == true
                      ? AppColors.greenLight
                      : AppColors.grey200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Cho vay",
                  style: AppTextStyles.medium14.copyWith(
                    color: state.isLending == true
                        ? AppColors.green
                        : AppColors.grey600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
