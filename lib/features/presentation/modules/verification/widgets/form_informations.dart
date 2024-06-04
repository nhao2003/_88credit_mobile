import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  final _nameFocusNode = FocusNode();
  final _idFocusNode = FocusNode();
  final _cardIssuedDateFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();

  GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  var fullNameTextController = TextEditingController();
  var identityCardNoTextController = TextEditingController();
  var identityCardIssuedDateTextController = TextEditingController();
  var countryTextController = TextEditingController();
  var birthDayTextController = TextEditingController();
  var identityCardIssuedDate = DateTime.now();
  var birthday = DateTime.now();

  List<String> issuedByList = [
    "CỤC TRƯỞNG CỤC CẢNH SÁT DKQL CƯ TRÚ VÀ DLQG VỀ DÂN CƯ",
    "CỤC TRƯỞNG CỤC CẢNH SÁT QUẢN LÝ HÀNH CHÍNH VỀ TRẬT TỰ XÃ HỘI",
  ];

  @override
  void initState() {
    super.initState();
    userInfoFormKey = GlobalKey<FormState>();
    countryTextController.text = "Việt Nam";

    context.read<VerificationBloc>().add(ChangeIssueBy(issuedByList[0]));
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _idFocusNode.dispose();
    _cardIssuedDateFocusNode.dispose();
    _countryFocusNode.dispose();
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  bool checkCanfinish() {
    bool check = true;
    if (fullNameTextController.text.trim().isEmpty) check = check & false;
    if (identityCardNoTextController.text.trim().isEmpty) check = check & false;
    if (identityCardIssuedDateTextController.text.trim().isEmpty) {
      check = check & false;
    }
    if (birthDayTextController.text.trim().isEmpty) {
      check = check & false;
    }
    // if (!state.isApprove) check = check & false;
    // isCanClickInfo.value = check;
    return check;
  }

  String? validateTextField(String? value) {
    if (value!.trim().isEmpty) {
      return 'Required field must not be blank';
    }
    return null;
  }

  String? validateIdCardTextField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required field must not be blank';
    }
    // Loại bỏ khoảng trắng và ký tự dư thừa trong chuỗi đầu vào
    input = input.replaceAll(RegExp(r'\s+'), '');

    // Kiểm tra độ dài chuỗi
    if (input.length != 12) {
      return "Căn cước phải đủ 12 số";
    }

    // Kiểm tra chuỗi có chứa ký tự không phải số hay không
    if (!RegExp(r'^[0-9]+$').hasMatch(input)) {
      return "Căn cước công dân phải là số";
    }

    return null;
  }

  Future<void> handleDatePicker(
      TextEditingController controler, DateTime date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Theme.of(context).primaryColor,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      date = picked;
      controler.text = DateFormat('dd/MM/yyyy').format(picked);
      checkCanfinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userInfoFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              focusNode: _nameFocusNode,
              key: const ValueKey('name'),
              controller: fullNameTextController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      fullNameTextController.clear();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Full name',
                  labelText: "Họ và tên thật, có dấu, viết cách",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: validateTextField,
              onTapOutside: (event) {
                _nameFocusNode.unfocus();
                checkCanfinish();
              },
              onFieldSubmitted: (_) {
                // chuyen qua textfill tiep theo
                FocusScope.of(context).requestFocus(_idFocusNode);
                checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: _idFocusNode,
              key: const ValueKey('identityCard'),
              controller: identityCardNoTextController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      identityCardNoTextController.clear();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Căn cước công dân',
                  labelText: "Nhập đúng số Căn cước",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: validateIdCardTextField,
              onTapOutside: (event) {
                _idFocusNode.unfocus();
                checkCanfinish();
              },
              onFieldSubmitted: (_) {
                _idFocusNode.unfocus();
                checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('identityCardIssuedDate'),
              focusNode: _cardIssuedDateFocusNode,
              readOnly: true,
              controller: identityCardIssuedDateTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              onTap: () => handleDatePicker(
                  identityCardIssuedDateTextController, identityCardIssuedDate),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      handleDatePicker(identityCardIssuedDateTextController,
                          identityCardIssuedDate);
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '01/01/2023',
                  labelText: "Ngày cấp giấy tờ",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
                checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                return DropdownButtonFormField<String>(
                  value: state.issuedBy,
                  isExpanded: true,
                  isDense: true,
                  itemHeight: null,
                  style:
                      AppTextStyles.regular16.copyWith(color: AppColors.black),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "Chọn nơi cấp giấy tờ",
                    labelText: "Chọn nơi cấp giấy tờ",
                  ),
                  items: issuedByList.map((value) {
                    return DropdownMenuItem<String>(
                      value: value, // ensure this is unique
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return issuedByList.map<Widget>((item) {
                      return Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList();
                  },
                  onChanged: (value) {
                    // changeIssueBy(value!);
                    context.read<VerificationBloc>().add(ChangeIssueBy(value!));
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Vui lòng chọn nơi cấp giấy tờ";
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('country'),
              enabled: false,
              focusNode: _birthdayFocusNode,
              readOnly: true,
              controller: countryTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Việt Nam',
                  labelText: "Quốc tịch",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('birthday'),
              focusNode: _birthdayFocusNode,
              readOnly: true,
              controller: birthDayTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              onTap: () => handleDatePicker(birthDayTextController, birthday),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      handleDatePicker(birthDayTextController, birthday);
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '01/01/2023',
                  labelText: "Ngày sinh",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
                checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: RadioListTile<bool>(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: true,
                          groupValue: state.isMale,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Nam",
                            style: AppTextStyles.regular16,
                          ),
                          onChanged: (ind) {
                            context
                                .read<VerificationBloc>()
                                .add(ChangeGender(ind!));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: RadioListTile<bool>(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          contentPadding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          groupValue: state.isMale,
                          title: Text(
                            "Nữ",
                            style: AppTextStyles.regular16,
                          ),
                          onChanged: (ind) {
                            context
                                .read<VerificationBloc>()
                                .add(ChangeGender(ind!));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                return SizedBox(
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
                      checkCanfinish();
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
