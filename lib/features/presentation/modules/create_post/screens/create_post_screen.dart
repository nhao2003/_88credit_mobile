import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/base_card.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/borrowing_form.dart';
import '../widgets/choose_lending_card.dart';
import '../widgets/lending_form.dart';
import '../widgets/post_info_card.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Đăng tin',
      ),
      body: ListView(
        children: [
          Column(
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
                child: PostInfoCard(),
              ),
              BorrowingForm(
                isvisible: !controller.isLending.value,
              ),
              LendingForm(
                isvisible: controller.isLending.value,
              ),
              // dang bai ============================================
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.createPost();
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
                  child: controller.isLoading.value
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
                          style: AppTextStyles.bold14.colorEx(AppColors.white),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
