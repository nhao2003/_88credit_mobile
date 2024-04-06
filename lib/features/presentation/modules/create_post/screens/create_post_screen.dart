import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/base_card.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/create_post_bloc.dart';
import '../widgets/borrowing_form.dart';
import '../widgets/choose_lending_card.dart';
import '../widgets/lending_form.dart';
import '../widgets/post_info_card.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final infoFormKey = GlobalKey<FormState>();
  final borrowingFormKey = GlobalKey<FormState>();
  final lendingFormKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Đăng tin',
      ),
      body: ListView(
        children: [
          BlocBuilder<CreatePostBloc, CreatePostState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // choose is lease
                  const BaseCard(
                    title: "Loại bài đăng",
                    isvisible: true,
                    child: ChooseLendingCard(),
                  ),
                  // Thong tin bai dang
                  BaseCard(
                    title: "Thông tin bài đăng",
                    isvisible: true,
                    child: PostInfoCard(
                      infoFormKey: infoFormKey,
                      titleTextController: titleTextController,
                      descriptionTextController: descriptionTextController,
                    ),
                  ),
                  BorrowingForm(
                    isvisible: !state.isLending,
                    borrowingFormKey: borrowingFormKey,
                  ),
                  LendingForm(
                    isvisible: state.isLending,
                    lendingFormKey: lendingFormKey,
                  ),
                  // dang bai ============================================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: state.status == CreatePostStatus.loading
                          ? null
                          : () {
                              context.read<CreatePostBloc>().add(
                                    SendPostEvent(
                                      titleTextController.text.trim(),
                                      descriptionTextController.text.trim(),
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(color: AppColors.white),
                        elevation: 10,
                        minimumSize: Size(100.wp, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state.status == CreatePostStatus.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Đăng bài',
                              style:
                                  AppTextStyles.bold14.colorEx(AppColors.white),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
