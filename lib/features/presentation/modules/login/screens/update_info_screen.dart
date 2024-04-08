import 'dart:io';

import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/utils/date_picker.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/dropdown_with_title.dart';
import '../widgets/image_avatar_picker.dart';
import '../widgets/text_field_with_title.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final updateInfoFormKey = GlobalKey<FormState>();

  final _fnameFocusNode = FocusNode();
  final _lnameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _birthFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  var fnamUpdateInfoTextController = TextEditingController();
  var lnameUpdateInfoTextController = TextEditingController();
  var phoneUpdateInfoTextController = TextEditingController();
  var emailUpdateInfoTextController = TextEditingController();
  var birthUpdateInfoTextController = TextEditingController();
  var genderUpdateInfoTextController = TextEditingController();
  var addressUpdateInfoTextController = TextEditingController();

  File? imageAvatar; // file image of user

  String gender = "Nam";

  void changeGender(String? newValue) {
    gender = newValue!;
  }

  @override
  void dispose() {
    updateInfoFormKey.currentState?.dispose();

    _fnameFocusNode.dispose();
    _lnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _birthFocusNode.dispose();

    fnamUpdateInfoTextController.dispose();
    lnameUpdateInfoTextController.dispose();
    phoneUpdateInfoTextController.dispose();
    emailUpdateInfoTextController.dispose();
    birthUpdateInfoTextController.dispose();
    genderUpdateInfoTextController.dispose();
    addressUpdateInfoTextController.dispose();
    super.dispose();
  }

  String getEmail() {
    return "minhphan46@gmail.com";
  }

  /// get day from date picker
  Future<void> handleDatePicker() async {
    DateTime? date = await DatePickerHelper.getDatePicker(context);
    if (date != null) {
      birthUpdateInfoTextController.text =
          DateFormat('dd/MM/yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    emailUpdateInfoTextController.text = getEmail();

    return Scaffold(
      appBar: const MyAppbar(title: "Cập nhập thông tin"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: updateInfoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
// image avatar
              ImageAvatarPicker(
                imageAvatar: imageAvatar,
              ),
              const SizedBox(height: 12),
// text avatar
              Center(
                child: Text(
                  "Thay đổi ảnh đại diện",
                  style: AppTextStyles.bold16.colorEx(AppColors.green),
                ),
              ),
// text field Ho & ten
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWithTitle(
                    titleText: "Họ",
                    hintText: "Nhập họ",
                    enable: true,
                    canTap: true,
                    keyBoardType: TextInputType.name,
                    focusNode: _lnameFocusNode,
                    nexFocusNode: _fnameFocusNode,
                    textController: lnameUpdateInfoTextController,
                    weightField: 30,
                    validateFunc: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Làm ơn nhập họ',
                  ),
                  TextFieldWithTitle(
                    titleText: "Tên",
                    hintText: "Nhập tên",
                    enable: true,
                    canTap: true,
                    keyBoardType: TextInputType.name,
                    focusNode: _fnameFocusNode,
                    nexFocusNode: _phoneFocusNode,
                    textController: fnamUpdateInfoTextController,
                    weightField: 52,
                    validateFunc: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Làm ơn nhập tên',
                  ),
                ],
              ),
// text field so dien thoai
              const SizedBox(height: 12),
              TextFieldWithTitle(
                region: "+84",
                titleText: "Số điện thoại",
                hintText: "Nhập số điện thoại",
                enable: true,
                canTap: true,
                keyBoardType: TextInputType.phone,
                focusNode: _phoneFocusNode,
                textController: phoneUpdateInfoTextController,
                weightField: 70,
                validateFunc: (value) => (!(value == null || value == ''))
                    ? null
                    : 'Làm ơn nhập số điện thoại',
              ),
// text field email
              const SizedBox(height: 12),
              TextFieldWithTitle(
                titleText: "Email",
                hintText: "Nhập email",
                enable: false,
                canTap: true,
                keyBoardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                textController: emailUpdateInfoTextController,
                weightField: 85,
                validateFunc: () {},
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
// text field date of birth
                  TextFieldWithTitle(
                    titleText: "Ngày sinh",
                    hintText: "Nhập ngày sinh",
                    enable: true,
                    canTap: false,
                    keyBoardType: TextInputType.datetime,
                    focusNode: _birthFocusNode,
                    textController: birthUpdateInfoTextController,
                    weightField: 50,
                    validateFunc: () {},
                    onTap: handleDatePicker,
                  ),
// drop down button gender
                  DropdownWithTitle(
                    titleText: "Giới tính",
                    weightField: 32,
                    value: gender,
                    onChanged: changeGender,
                  )
                ],
              ),
// text field address
              const SizedBox(height: 12),
              TextFieldWithTitle(
                titleText: "Địa chỉ",
                hintText: "Nhập địa chỉ",
                enable: true,
                canTap: true,
                keyBoardType: TextInputType.streetAddress,
                focusNode: _addressFocusNode,
                textController: addressUpdateInfoTextController,
                weightField: 85,
                validateFunc: (value) => (!(value == null || value == ''))
                    ? null
                    : 'Làm ơn nhập địa chỉ của bạn',
              ),
// Button luu
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  // handleRegister();
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.bottomBar);
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
                child: Text(
                  'Lưu',
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
