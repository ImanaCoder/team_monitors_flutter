import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:team_monitor/utils/http.dart';

class SmsService {
  Future sendSms(String to, String message, {String from = 'infosms'}) async {
    return await handleAsync(() async {
      final String emailHtmlBody = """
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
              body {
                  font-family: Arial, sans-serif;
                  background-color: #f4f4f4;
                  margin: 0;
                  padding: 0;
                  color: #333;
              }
              .container {
                  width: 100%;
                  max-width: 600px;
                  margin: 0 auto;
                  background-color: #ffffff;
                  padding: 20px;
                  border-radius: 8px;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
              }
              .header {
                  text-align: center;
                  padding: 20px 0;
                  background-color: #007bff;
                  color: #ffffff;
                  border-radius: 8px 8px 0 0;
              }
              .content {
                  padding: 20px;
              }
              .footer {
                  text-align: center;
                  padding: 10px;
                  font-size: 12px;
                  color: #777777;
              }
              .button {
                  display: inline-block;
                  padding: 10px 20px;
                  margin: 20px 0;
                  background-color: #007bff;
                  color: #ffffff;
                  text-decoration: none;
                  border-radius: 5px;
              }
          </style>
      </head>
      <body>
          <div class="container">
              <div class="header">
                  <h1>Welcome to Team Monitors</h1>
              </div>
              <div class="content">
                  <p>Hello,</p>
                  <p>$message</p>
                  <a href="https://team-monitors.com" class="button">Visit Team Monitor</a>
              </div>
              <div class="footer">
                  <p>&copy; 2024 Team Monitors. All rights reserved.</p>
              </div>
          </div>
      </body>
      </html>
      """;

      final Email email = Email(
        body: emailHtmlBody,
        subject: 'Confirm Your Email Address',
        recipients: [to],
        cc: [], // Add CC recipients if any
        bcc: [], // Add BCC recipients if any
        attachmentPaths: [], // Add attachment paths if any
        isHTML: true, // Set to true to send HTML email
      );

      await FlutterEmailSender.send(email);
    });
  }
}
