import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenInfo {
  AuthToken? authToken;
  JwtClaims? claims;
  // String? fcmToken;
  String get currentUserRole => claims?.role[0] ?? "";

  Future<void> clear() async {
    authToken = null;
    claims = null;
    await const FlutterSecureStorage().delete(key: 'accessToken');
  }
}

class AuthToken {
  late String accessToken;

  AuthToken({required this.accessToken});

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(accessToken: json['accessToken']);
  }

  bool isExpired() => JwtDecoder.isExpired(accessToken);
}

class JwtClaims {
  late String tokenVersion;
  late String userDetailsId;
  late String userId, userName;
  late List<dynamic> role;

  JwtClaims({
    required this.userId,
    required this.userDetailsId,
    required this.userName,
    required this.tokenVersion,
    required this.role,
  });

  factory JwtClaims.fromToken(String token) {
    var data = JwtDecoder.decode(token);
    var dynamicRole = data['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

    return JwtClaims(
      userId: data['userId'],
      userDetailsId: data['userDetailsId'],
      userName: data['userName'],
      tokenVersion: data['tokenVersion'],
      role: dynamicRole.runtimeType == String ? [dynamicRole] : dynamicRole,
    );
  }
}
