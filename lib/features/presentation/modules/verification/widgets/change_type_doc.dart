import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/enums/type_indetification_document.dart';
import '../bloc/verification_bloc.dart';

class ChangeTypeDoc extends StatelessWidget {
  const ChangeTypeDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // icon
          Row(
            children: [
              Image.asset(
                Assets.idCard,
                height: 25,
                color: AppColors.green,
              ),
              const SizedBox(width: 10),
              BlocBuilder<VerificationBloc, VerificationState>(
                builder: (context, state) {
                  return Text(
                    state.typeIndetificationDocument.toString(),
                    style: AppTextStyles.regular14,
                  );
                },
              ),
            ],
          ),

          // text
          TextButton(
            onPressed: () {
              //_controller.changeTypeIdentityDocuments();
              showChossTypeDialog(context);
            },
            child: Text(
              "Thay đổi",
              style: AppTextStyles.regular14.copyWith(color: AppColors.green),
            ),
          )
          // text
        ],
      ),
    );
  }

  showChossTypeDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        void changeType(int ind) {
          context.read<VerificationBloc>().add(ChangeSelectedRadio(ind));
          var documentType = TypeIndetificationDocument.chungMinhNhanDan;
          if (ind == 0) {
            documentType = TypeIndetificationDocument.chungMinhNhanDan;
          } else if (ind == 1) {
            documentType = TypeIndetificationDocument.canCuocCongDan;
          } else {
            documentType = TypeIndetificationDocument.hoChieu;
          }
          context
              .read<VerificationBloc>()
              .add(ChangeTypeIndetificationDocument(documentType));
          Navigator.pop(context);
        }

        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return BlocBuilder<VerificationBloc, VerificationState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Loại giấy tờ",
                        style: AppTextStyles.bold20,
                      ),
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 50,
                          child: RadioListTile(
                            value: 0,
                            groupValue: state.selectedRadio,
                            contentPadding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0),
                            title: Text(
                              "Chứng minh nhân dân",
                              style: AppTextStyles.regular14,
                            ),
                            onChanged: (ind) {
                              changeType(ind!);
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: RadioListTile(
                            value: 1,
                            groupValue: state.selectedRadio,
                            contentPadding: const EdgeInsets.only(left: 0),
                            title: Text(
                              "Căn cước công dân",
                              style: AppTextStyles.regular14,
                            ),
                            onChanged: (ind) {
                              changeType(ind!);
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: RadioListTile(
                            value: 2,
                            groupValue: state.selectedRadio,
                            contentPadding: const EdgeInsets.only(left: 0),
                            title: Text(
                              "Hộ chiếu",
                              style: AppTextStyles.regular14,
                            ),
                            onChanged: (ind) {
                              changeType(ind!);
                              setState(() {});
                            },
                          ),
                        ),
                      ]),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
