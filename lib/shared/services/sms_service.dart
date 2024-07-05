import 'package:team_monitor/utils/http.dart';

class SmsService {
  Future sendSms(String to, String message) async {
    return await handleAsync(() async {
      String path = "$baseUrl/api/auth/send-email";
      print(path);
      await dio.post(path, data: {"email": to, "message": message});
    });
  }
}
