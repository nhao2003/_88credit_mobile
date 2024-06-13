import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/verification_bloc.dart';

class FormInfomations extends StatefulWidget {
  const FormInfomations({super.key});

  @override
  State<FormInfomations> createState() => _FormInfomationsState();
}

class _FormInfomationsState extends State<FormInfomations> {
  GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  var idTC = TextEditingController();
  var nameTC = TextEditingController();
  var birthDayTC = TextEditingController();
  var genderTC = TextEditingController();
  var nationalityTC = TextEditingController();
  var originLocationTC = TextEditingController();
  var recentLocationTC = TextEditingController();
  var cardTypeTC = TextEditingController();
  var issuePlaceTC = TextEditingController();
  var featuresTC = TextEditingController();
  var issueDateTC = TextEditingController();

  @override
  void initState() {
    super.initState();
    userInfoFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    idTC.dispose();
    nameTC.dispose();
    birthDayTC.dispose();
    nationalityTC.dispose();
    genderTC.dispose();
    originLocationTC.dispose();
    recentLocationTC.dispose();
    cardTypeTC.dispose();
    issuePlaceTC.dispose();
    featuresTC.dispose();
    issueDateTC.dispose();
    super.dispose();
  }

  void initValue(VerificationState state) {
    idTC.text = state.frontCardInfo.id ?? "";
    nameTC.text = state.frontCardInfo.name ?? "";
    genderTC.text = state.frontCardInfo.gender ?? "";
    birthDayTC.text = state.frontCardInfo.birthDay ?? "";
    nationalityTC.text = state.frontCardInfo.nationality ?? "";
    originLocationTC.text = state.frontCardInfo.originLocation ?? "";
    recentLocationTC.text = state.frontCardInfo.recentLocation ?? "";
    cardTypeTC.text = state.frontCardInfo.cardType ?? "";
    issuePlaceTC.text = state.backCardInfo.issuePlace ?? "";
    featuresTC.text = state.backCardInfo.features ?? "";
    issueDateTC.text = state.backCardInfo.issueDate ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationBloc, VerificationState>(
      builder: (context, state) {
        initValue(state);

        return Form(
          key: userInfoFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: idTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      hintText: 'Việt Nam',
                      labelText: "Quốc tịch",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: nameTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Họ và tên",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: birthDayTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Ngày sinh",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: genderTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Giới tính",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: nationalityTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Quốc tịch",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: originLocationTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Quê quán",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: recentLocationTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      hintText: 'Việt Nam',
                      labelText: "Địa chỉ thường trú",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: issuePlaceTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      hintText: 'Việt Nam',
                      labelText: "Phát hành bởi",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: featuresTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Đặc điểm",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: issueDateTC,
                  maxLines: 1,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      filled: true,
                      fillColor: AppColors.grey100,
                      labelText: "Ngày cấp",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CheckboxListTile(
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    contentPadding: EdgeInsets.zero,
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tôi đồng ý với ",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.black),
                          ),
                          TextSpan(
                            text: "thỏa thuận sử dụng",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    'https://zalopay.vn/quy-dinh/thoa-thuan-su-dung-zalopay'));
                              },
                          ),
                          TextSpan(
                            text: " của Nhà Giá Rẻ",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    value: state.isApprove,
                    onChanged: (newValue) {
                      context
                          .read<VerificationBloc>()
                          .add(ChangeApprove(newValue!));
                      // checkCanfinish();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
