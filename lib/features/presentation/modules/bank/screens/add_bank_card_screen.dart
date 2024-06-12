import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/base_textfield.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/bank_bloc.dart';

class AddBankCardScreen extends StatefulWidget {
  const AddBankCardScreen({super.key});

  @override
  State<AddBankCardScreen> createState() => _AddBankCardScreenState();
}

class _AddBankCardScreenState extends State<AddBankCardScreen> {
  final FocusNode _moneyFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();

  @override
  void initState() {
    // cardNumberController.text = controller.selectedBank!.bin;
    super.initState();
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: "Thêm thẻ ngân hàng"),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: BlocBuilder<BankBloc, BankState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // avatar
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: CachedNetworkImage(
                                  imageUrl: state.selectedBank.logo,
                                  fit: BoxFit.contain,
                                  width: 70,
                                  height: 50,
                                  errorWidget: (context, _, __) {
                                    return const CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage(Assets.avatar2),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Name
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.selectedBank.shortName,
                                      style: AppTextStyles.bold14.colorEx(
                                        AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      state.selectedBank.name,
                                      style: AppTextStyles.regular14.colorEx(
                                        AppColors.grey700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          BaseTextField(
                              focusNode: _moneyFocusNode,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              controller: cardNumberController,
                              labelText: 'Số thẻ/tài khoản',
                              hintText: "Nhập số thẻ/tài khoản",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Vui lòng nhập số thẻ/tài khoản";
                                }
                                // check card number
                                if (value.trim().length < 16) {
                                  return "Số thẻ/tài khoản ít hơn 16 ký tự";
                                }
                                // validate all is number
                                if (!isNumeric(value.trim())) {
                                  return "Số thẻ/tài khoản phải là số";
                                }
                                // check bank number is begin with bin
                                if (!value.startsWith(state.selectedBank.bin)) {
                                  return "Số thẻ/tài khoản phải bắt đầu bằng ${state.selectedBank.bin}";
                                }
                                return null;
                              }),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          // thêm ngân hàng ============================================
          BlocBuilder<BankBloc, BankState>(
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed:
                      state.addBankCardStatus == AddBankCardStatus.loading
                          ? null
                          : () {
                              // addBankCard();
                              context.read<BankBloc>().add(AddBankCard(
                                    cardNumberController.text,
                                  ));
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
                  child: state.addBankCardStatus == AddBankCardStatus.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Thêm thẻ ngân hàng',
                          style: AppTextStyles.bold14.colorEx(AppColors.white),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
