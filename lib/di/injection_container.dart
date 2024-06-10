import 'package:_88credit_mobile/config/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/data/datasources/db/app_database.dart';
import '../features/data/datasources/local/authentication_local_data_source.dart';
import '../features/data/datasources/remote/authentication_remote_data_source.dart';
import '../features/data/datasources/remote/bank_remote_data_source.dart';
import '../features/data/datasources/remote/blog_data_source.dart';
import '../features/data/datasources/remote/media_remote_date_source.dart';
import '../features/data/datasources/remote/post_remote_data_sources.dart';
import '../features/data/datasources/remote/requests_remote_data_source.dart';
import '../features/data/repositories/authentication_repository_impl.dart';
import '../features/data/repositories/bank_repository_impl.dart';
import '../features/data/repositories/blog_repository_impl.dart';
import '../features/data/repositories/media_repository_impl.dart';
import '../features/data/repositories/post_repository_impl.dart';
import '../features/data/repositories/request_repository_impl.dart';
import '../features/domain/repositories/authentication_repository.dart';
import '../features/domain/repositories/bank_repository.dart';
import '../features/domain/repositories/blog_repository.dart';
import '../features/domain/repositories/media_repository.dart';
import '../features/domain/repositories/post_repository.dart';
import '../features/domain/repositories/request_repository.dart';
import '../features/domain/usecases/authentication/check_access_token.dart';
import '../features/domain/usecases/authentication/check_refresh_token.dart';
import '../features/domain/usecases/authentication/get_access_token.dart';
import '../features/domain/usecases/authentication/get_authen_biometrics.dart';
import '../features/domain/usecases/authentication/get_user_id.dart';
import '../features/domain/usecases/authentication/sign_in.dart';
import '../features/domain/usecases/authentication/sign_out.dart';
import '../features/domain/usecases/authentication/sign_up.dart';
import '../features/domain/usecases/bank/add_bank_card.dart';
import '../features/domain/usecases/bank/delete_bank_card.dart';
import '../features/domain/usecases/bank/get_all_banks.dart';
import '../features/domain/usecases/bank/get_bank_cards.dart';
import '../features/domain/usecases/bank/get_primary_bank_card.dart';
import '../features/domain/usecases/bank/mark_as_primary_bank_card.dart';
import '../features/domain/usecases/blog/get_blogs.dart';
import '../features/domain/usecases/contract/confirm_request.dart';
import '../features/domain/usecases/contract/create_loan_request.dart';
import '../features/domain/usecases/contract/get_borrowing_contracts.dart';
import '../features/domain/usecases/contract/get_lending_contracts.dart';
import '../features/domain/usecases/contract/get_loan_requests.dart';
import '../features/domain/usecases/contract/get_received_requests_status.dart';
import '../features/domain/usecases/contract/get_sent_requests_status.dart';
import '../features/domain/usecases/contract/reject_request.dart';
import '../features/domain/usecases/media/upload_file.dart';
import '../features/domain/usecases/post/create_post.dart';
import '../features/domain/usecases/post/get_posts.dart';

part 'injection_container.main.dart';
