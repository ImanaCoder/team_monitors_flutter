import 'dart:math';
import 'package:team_monitor/core/token_info.dart';
import 'package:team_monitor/utils/http.dart';

class UserService {
  Future<void> forgotPassword(String userName) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/auth/forgot-password";
      var data = {"UserName": userName};
      await dio.post(path, data: data);
    });
  }

  Future<void> resetUserPassword(var data) async {
    return await handleAsync(() async {
      String path = "$baseUrl/api/auth/reset-password";
      await dio.post(path, data: data);
    });
  }

  Future<void> registerCoSeller(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      String path = "$baseUrl/api/auth/register/co-seller";
      await dio.post(path, data: data);
    });
  }

  Future<AuthToken> login(Map<String, dynamic> data) async {
    return handleAsync(() async {
      var path = "$baseUrl/api/auth/login";
      var response = await dio.post(path, data: data);
      return AuthToken.fromJson(response.data);
    });
  }

  // Future<bool> checkUserExistance(String username) async {
  //   return await handleAsync(() async {
  //     String path = "$baseUrl/api/users/UserExistenceCheck?UserName=$username";
  //     Response response = await dio.get(path);
  //     return response.data["userExists"];
  //   });
  // }

  // Future<void> addFcmToken() async {
  //   return await handleAsync(() async {
  //     String path = "$baseUrl/api/users/add-fcm-token";
  //     var data = {"FcmToken": sl<TokenInfo>().fcmToken};
  //     await dio.post(path, data: data);
  //   });
  // }

  // Future<void> removeFcmToken() async {
  //   return await handleAsync(() async {
  //     String path = "$baseUrl/api/users/remove-fcm-token";
  //     await dio.post(path);
  //   });
  // }

  String generateRandomPassword() {
    double pass = Random().nextDouble() * 1000000 + 1;

    String password = pass.toStringAsFixed(0);
    return password;
  }
}
