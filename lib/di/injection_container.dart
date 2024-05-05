import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/data/datasources/local/authentication_local_data_source.dart';
import '../features/data/datasources/remote/authentication_remote_data_source.dart';
import '../features/data/repositories/authentication_repository_impl.dart';
import '../features/domain/repositories/authentication_repository.dart';
import '../features/domain/usecases/authentication/check_token.dart';
import '../features/domain/usecases/authentication/get_access_token.dart';
import '../features/domain/usecases/authentication/get_authen_biometrics.dart';
import '../features/domain/usecases/authentication/get_user_id.dart';
import '../features/domain/usecases/authentication/sign_in.dart';
import '../features/domain/usecases/authentication/sign_out.dart';
import '../features/domain/usecases/authentication/sign_up.dart';

part 'injection_container.main.dart';
