import 'package:_88credit_mobile/features/presentation/modules/bank/bloc/bank_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/bank/screens/add_bank_card_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/bank/screens/bank_list_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/bank/screens/bank_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/blogs/bloc/blog_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/blogs/screens/blog_detail_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/call/bloc/call_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/call/screens/call_video_sceen.dart';
import 'package:_88credit_mobile/features/presentation/modules/call/screens/connect_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/call/screens/login_call_page.dart';
import 'package:_88credit_mobile/features/presentation/modules/chat/screens/chat_detail_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/chat/screens/chat_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/chat_bot/screens/chat_bot_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/create_request.dart/bloc/create_request_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/create_request.dart/screens/change_user_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/create_request.dart/screens/create_request_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/qr_code/bloc/qr_code_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/qr_code/screens/generate_code_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/qr_code/screens/scan_code_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/screens/request_sent_tab_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/request_detail.dart/bloc/request_detail_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/request_detail.dart/screens/request_detail_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/splash/splash_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/bloc/user_profile_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/screens/user_profile_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/verification/bloc/verification_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/verification/screens/verification_card_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/verification/screens/verification_portrait_screen.dart';
import '../../core/resources/base_app_pages.dart';
import '../../features/presentation/modules/blogs/screens/blog_screen.dart';
import '../../features/presentation/modules/chat/bloc/chat_bloc.dart';
import '../../features/presentation/modules/chat_bot/bloc/chat_bot_bloc.dart';
import '../../features/presentation/modules/contract/screens/contract_screen.dart';
import '../../features/presentation/modules/contract_detail/screens/contract_detail_screen.dart';
import '../../features/presentation/modules/account/screens/account_screen.dart';
import '../../features/presentation/modules/bottom_bar/bloc/bar_bloc.dart';
import '../../features/presentation/modules/bottom_bar/bottom_bar_screen.dart';
import '../../features/presentation/modules/contract/bloc/contract_bloc.dart';
import '../../features/presentation/modules/request/bloc/request_bloc.dart';
import '../../features/presentation/modules/request/screens/request_screen.dart';
import '../../features/presentation/modules/request/screens/request_received_tab_screen.dart';
import '../../features/presentation/modules/create_post/bloc/create_post_bloc.dart';
import '../../features/presentation/modules/home/bloc/home_bloc.dart';
import '../../features/presentation/modules/home/screens/home_screen.dart';
import '../../features/presentation/modules/login/screens/forgot_password_sceen.dart';
import '../../features/presentation/modules/login/screens/login_screen.dart';
import '../../features/presentation/modules/login/screens/register_screen.dart';
import '../../features/presentation/modules/login/screens/update_password_sceen.dart';
import '../../features/presentation/modules/post/bloc/post_bloc.dart';
import '../../features/presentation/modules/post/screens/post_screen.dart';
import '../../features/presentation/modules/post_detail/bloc/post_detail_bloc.dart';
import '../../features/presentation/modules/post_detail/screens/post_detail_screen.dart';
import '../../features/presentation/modules/account/bloc/account_bloc.dart';
import '../../features/presentation/modules/create_post/screens/create_post_screen.dart';
import '../../features/presentation/modules/login/bloc/auth_bloc.dart';
import '../../features/presentation/modules/login/screens/update_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/presentation/modules/verification/screens/verification_info_screen.dart';
import '../../features/presentation/modules/verification/screens/verification_reject_screen.dart';
import '../../features/presentation/modules/verification/screens/verification_waiting_screen.dart';
import 'app_routes.dart';

part 'app_pages.main.dart';
