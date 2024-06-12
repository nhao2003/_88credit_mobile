import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/loading_component.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../../../globalwidgets/not_identity_card.dart';
import '../bloc/account_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AccountBloc>().add(GetUserProfile());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Tài khoản", isShowBack: false, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Image.asset(
            Assets.chat,
            width: 25,
            height: 25,
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: ListTile.divideTiles(
            color: AppColors.grey100,
            context: context,
            tiles: [
              // account
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.userProfile,
                          arguments: state.user);
                    },
                    title: state.getAccountStatus == GetAccountStatus.loading
                        ? const LoadingComponent(color: AppColors.green)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.user.fullName,
                                    style: AppTextStyles.medium16,
                                  ),
                                  const SizedBox(width: 2),
                                  if (state.isIdentity)
                                    Image.asset(
                                      Assets.badge,
                                      height: 15,
                                      width: 15,
                                    ),
                                ],
                              ),
                              if (!state.isIdentity) const NotIdentityCard(),
                            ],
                          ),
                    leading: state.getAccountStatus == GetAccountStatus.success
                        ? ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: CachedNetworkImage(
                              imageUrl: state.user.avatar!,
                              fit: BoxFit.cover,
                              width: 36,
                              height: 36,
                              errorWidget: (context, _, __) {
                                return const CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      AssetImage(Assets.avatarDefault),
                                );
                              },
                            ),
                          )
                        : const CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(Assets.avatarDefault),
                          ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  );
                },
              ),
              // favorite
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Xác thực danh tính',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.verificationCard);
                },
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.admin_panel_settings_outlined,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // purchase
              // BlocBuilder<AccountBloc, AccountState>(
              //   builder: (context, state) {
              //     return ListTile(
              //       contentPadding:
              //           const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Gói dịch vụ',
              //             style: AppTextStyles.medium16,
              //           ),
              //           const SizedBox(height: 2),
              //           if (state.servicePack != 0)
              //             Container(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 8, vertical: 2),
              //               decoration: BoxDecoration(
              //                 color: state.servicePack == 1
              //                     ? AppColors.green100
              //                     : state.servicePack == 2
              //                         ? AppColors.blue100
              //                         : AppColors.red100,
              //                 borderRadius: BorderRadius.circular(4),
              //               ),
              //               child: Text(
              //                 state.servicePack == 1
              //                     ? "Gói cơ bản"
              //                     : state.servicePack == 2
              //                         ? "Gói chuyên nghiệp"
              //                         : "Gói doanh nghiệp",
              //                 style: AppTextStyles.medium12
              //                     .colorEx(state.servicePack == 1
              //                         ? AppColors.green800
              //                         : state.servicePack == 2
              //                             ? AppColors.blue800
              //                             : AppColors.red),
              //               ),
              //             )
              //         ],
              //       ),
              //       onTap: () {
              //         Navigator.of(context).pushNamed(AppRoutes.purchase);
              //       },
              //       leading: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 5),
              //         child: Image.asset(
              //           Assets.archive,
              //           height: 25,
              //           color: AppColors.black,
              //         ),
              //       ),
              //       trailing: const Icon(
              //         Icons.arrow_forward_ios_rounded,
              //         size: 18,
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //   contentPadding:
              //       const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              //   title: Text(
              //     'Quản lý bài đăng',
              //     style: AppTextStyles.medium16,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(AppRoutes.postManagement);
              //   },
              //   leading: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     child: Image.asset(
              //       Assets.chart,
              //       height: 25,
              //       color: AppColors.black,
              //     ),
              //   ),
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: 18,
              //   ),
              // ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Quản lý thẻ ngân hàng',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.bank);
                },
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.credit_card,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // update info
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Cập nhập thông tin',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {},
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.edit_outlined,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // change Password
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Đổi mật khẩu',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {},
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // change language
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                title: Text(
                  'Ngôn ngữ',
                  style: AppTextStyles.medium16,
                ),
                onTap: () {},
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.language_outlined,
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
              // logout
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state.signoutStatus == SignoutStatus.success) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.login,
                        (Route<dynamic> route) => false,
                      );
                    });
                    context.snackBar('Đăng xuất thành công!');
                  } else if (state.signoutStatus == SignoutStatus.failure) {
                    context.snackBar(state.signoutError,
                        type: SnackBarType.error);
                  }

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    title: state.signoutStatus == SignoutStatus.loading
                        ? const LoadingComponent(color: AppColors.red)
                        : Text(
                            'Đăng xuất',
                            style:
                                AppTextStyles.medium16.colorEx(AppColors.red),
                          ),
                    onTap: () {
                      // controller.handleSignOut();
                      context.read<AccountBloc>().add(SigoutEvent());
                    },
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.logout,
                        color: AppColors.red,
                        size: 25,
                      ),
                    ),
                  );
                },
              )
            ],
          ).toList(),
        ),
      ),
    );
  }
}
