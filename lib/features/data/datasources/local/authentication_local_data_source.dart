import 'package:_88credit_mobile/core/utils/device_info.dart';
import 'package:_88credit_mobile/core/utils/hash_utils.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthenLocalDataSrc {
  Future<void> storeRefreshToken(String refreshToken);
  Future<void> storeAccessToken(String accessToken);
  Future<String?> getRefreshToken();
  String? getAccessToken();
  Future<void> deleteRefreshToken();
  Future<void> deleteAccessToken();
  String getUserIdFromToken();
  Future<bool> hasBiometrics();
  Future<List<BiometricType>> getBiometrics();
  Future<bool> authenticateBiometrics();
}

class AuthenLocalDataSrcImpl implements AuthenLocalDataSrc {
  late SharedPreferences client;
  late final LocalAuthentication localAuth;
  AuthenLocalDataSrcImpl(this.client, this.localAuth);

  String? getSharedPreferencesValue(String key) {
    try {
      return client.getString(key);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  Future<void> setSharedPreferencesValue(String key, String value) async {
    try {
      await client.setString(key, value);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  Future<void> removeSharedPreferencesValue(String key) async {
    try {
      await client.remove(key);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  String? getAccessToken() {
    return getSharedPreferencesValue('accessToken');
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      String? encodeToken = getSharedPreferencesValue('refreshToken');
      if (encodeToken == null) return null;
      print("encodeRefreshToken after: $encodeToken");
      String? deviceID = await DeviceInfo.getDeviceID();
      print("deviceID after: $deviceID");
      String refreshToken =
          HashUtils.decode(encodeToken, password: deviceID ?? "");
      print("refreshToken after: $refreshToken");
      return refreshToken;
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 1000);
    }
  }

  @override
  Future<void> storeAccessToken(String accessToken) async {
    setSharedPreferencesValue('accessToken', accessToken);
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    try {
      print("refreshToken before: $refreshToken");
      String? deviceID = await DeviceInfo.getDeviceID();
      print("deviceID before: $deviceID");
      String encodedToken =
          HashUtils.encode(refreshToken, password: deviceID ?? "");
      print("encodeRefreshToken before: $encodedToken");
      setSharedPreferencesValue('refreshToken', encodedToken);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 1000);
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    removeSharedPreferencesValue('accessToken');
  }

  @override
  Future<void> deleteRefreshToken() async {
    removeSharedPreferencesValue('refreshToken');
  }

  @override
  String getUserIdFromToken() {
    try {
      String? token = client.getString('accessToken');
      if (JwtDecoder.isExpired(token!)) {
        throw const SharedPreferencesException(
            message: "Token is expired", statusCode: 500);
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken["user_id"];
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<bool> hasBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await localAuth.canCheckBiometrics;
      return canAuthenticateWithBiometrics ||
          await localAuth.isDeviceSupported();
      // return await localAuth.canCheckBiometrics;
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await localAuth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      return <BiometricType>[];
    }
  }

  @override
  Future<bool> authenticateBiometrics() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await localAuth.authenticate(
        localizedReason: 'Vui lòng quét dấu vân tay để tiếp tục',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}
