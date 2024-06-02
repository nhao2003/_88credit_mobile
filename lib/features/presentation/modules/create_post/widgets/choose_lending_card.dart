import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/enums/post_type.dart';
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
                    .add(const TogglePageEvent(PostTypes.borrowing));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: state.postType == PostTypes.borrowing
                      ? AppColors.greenLight
                      : AppColors.grey200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Vay tiền",
                  style: AppTextStyles.medium14.copyWith(
                    color: state.postType == PostTypes.borrowing
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
                context
                    .read<CreatePostBloc>()
                    .add(const TogglePageEvent(PostTypes.lending));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: state.postType == PostTypes.lending
                      ? AppColors.greenLight
                      : AppColors.grey200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Cho vay",
                  style: AppTextStyles.medium14.copyWith(
                    color: state.postType == PostTypes.lending
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
