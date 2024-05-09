import 'package:codeal/utils/http.dart';

class SmsService {
  Future sendSms(String to, String message, {String from = 'infosms'}) async {
    return await handleAsync(() async {
      String smsUrl = "https://sms.aakashsms.com/sms/v3/send";
      var authToken = "6b004cdea8e51af0dcb655b2211a1566cf84d0cec66a0f9b5626ad4d6e903482";

      var data = {
        'auth_token': authToken,
        'to': to,
        'text': message,
      };

      await dio.post(smsUrl, data: data);
    });
  }
}
