import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../../request_detail.dart/widgets/credit_card.dart';
import '../../request_detail.dart/widgets/user_card.dart';
import '../widgets/images_form.dart';
import '../widgets/loan_info_form.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  @override
  void initState() {
    if (Get.arguments != null) {
      controller.receiver.value = Get.arguments;
    }
    controller.getPrimaryBankCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: "Tạo yêu cầu vay"),
      body: ListView(
        children: [
          Form(
            key: controller.requestFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Obx(
                  () => Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: UserCard(
                      title: "Người cho vay",
                      name: controller.receiver.value.fullName,
                      avatar: controller.receiver.value.avatar,
                      buttonText: "Thay đổi",
                      navToProfile: () {
                        Navigator.of(context).pushNamed(AppRoutes.changeUser);
                      },
                    ),
                  ),
                ),

                Obx(
                  () => Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: controller.isGetingPrimaryBankCard.value
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                  strokeWidth: 2,
                                ),
                              ),
                            ))
                        : controller.primaryBankCard.value == null ||
                                controller.primaryBankCard.value!.cardNumber ==
                                    null
                            ? CreditCard(
                                bankName: "Chọn thẻ",
                                bankNumber: "Không có dữ liệu",
                                hanleChooseCard: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.bank);
                                },
                                buttonText: "Chọn thẻ",
                              )
                            : CreditCard(
                                bankName: controller
                                    .primaryBankCard.value!.bank!.shortName,
                                bankNumber: controller
                                    .primaryBankCard.value!.cardNumber!,
                                logoBank: controller
                                    .primaryBankCard.value!.bank!.logo,
                                hanleChooseCard: () {
                                  controller.navigateToBank();
                                },
                                buttonText: "Đổi thẻ",
                              ),
                  ),
                ),
                // Thong tin bai dang
                LoanInfoForm(
                  isvisible: true,
                ),
                // images
                const ImagesForm(
                  isvisible: true,
                ),
                // dang bai ============================================
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.createRequest();
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
                            'Tạo yêu cầu',
                            style:
                                AppTextStyles.bold14.colorEx(AppColors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
