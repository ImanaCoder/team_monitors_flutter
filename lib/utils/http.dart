import 'package:team_monitor/core/navigation_service.dart';
import 'package:team_monitor/core/service_locator.dart';
import 'package:dio/dio.dart';

import '../core/token_info.dart';

// SERVER
String baseUrl = "http://192.168.1.68:5092";
// String baseUrl = "http://110.34.25.242";

Dio dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add the access token to the request header
        if (sl<TokenInfo>().authToken != null) {
          options.headers['Authorization'] =
              'Bearer ${sl<TokenInfo>().authToken!.accessToken}';
        }
        return handler.next(options);
      },
    ),
  );
// ..interceptors.add(
//   PrettyDioLogger(
//       requestHeader: false,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: false,
//       error: true,
//       compact: true,
//       maxWidth: 90),
// );

Future<T> handleAsync<T>(Future<T> Function() onTry,
    {String unAuthorizedMsg = "Session Expired, please login"}) async {
  try {
    return await onTry();
  } on DioException catch (e) {
    if (e.response == null) throw Exception("Network Issue");

    if (e.response!.statusCode == 404)
      throw MyAppException(e.response!.data["Message"] ?? "not found");

    if (e.response!.statusCode == 401) {
      sl<NavigationService>().navigateToLogin();
      throw MyAppException(unAuthorizedMsg);
    }

    if (e.response!.statusCode == 400)
      throw MyAppException(e.response!.data["message"] ?? "invalid request");

    throw const MyAppException("ERROR!");
  } catch (e) {
    // print(e.toString());
    throw const MyAppException('Something went wrong');
  }
}

class MyAppException implements Exception {
  final String message;
  const MyAppException(this.message);

  @override
  String toString() => message;
}
