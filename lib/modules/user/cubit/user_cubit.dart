import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/user/service/user_service.dart';
import 'package:team_monitor/shared/services/sms_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_monitor/core/token_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  var userService = sl<UserService>();

  void registerAsCoSeller(Map<String, dynamic> data) async {
    emit(UserLoading());
    try {
      await userService.registerCoSeller(data);
      emit(UserRegistered());
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void sendOtp(String to) async {
    emit(UserLoading());
    try {
      var otp = userService.generateRandomPassword();
      var message = "Your OTP for Co-Deal: $otp";
      await sl<SmsService>().sendSms(to, message);
      emit(OtpSent(otp: otp));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void loginUser(Map<String, String> loginData) async {
    emit(UserLoading());
    try {
      var authToken = await userService.login(loginData);

      const storage = FlutterSecureStorage();
      await storage.write(key: 'accessToken', value: authToken.accessToken);
      sl<TokenInfo>().authToken = authToken;
      sl<TokenInfo>().claims = JwtClaims.fromToken(authToken.accessToken);
      emit(UserLoggedIn());

      // fetching user data (we need it almost everywhere)
      // late User user;
      // Future<void> getUser() async => user = await UserService.getLoginData();
      // await Future.wait([getUser(), UserService.addFcmToken()]);
      // User.currentUser = user;
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void preLoginProcessing() async {
    emit(UserLoading());
    try {
      const storage = FlutterSecureStorage();
      var accessToken = await storage.read(key: 'accessToken');
      if (accessToken == null) {
        emit(TokenError()); // Token not found in secure storage.
      } else {
        var authToken = AuthToken(accessToken: accessToken);
        sl<TokenInfo>().authToken = authToken;
        sl<TokenInfo>().claims = JwtClaims.fromToken(accessToken);

        // fetching user data (we need it almost everywhere)
        // if (!authToken.isExpired()) {
        //   var user = await UserService.getLoginData();
        //   User.currentUser = user;
        // }

        if (authToken.isExpired()) {
          emit(TokenError());
        } else {
          // var user = await UserService.getLoginData();
          // User.currentUser = user;
          emit(TokenVerified());
        }
      }
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void forgotPassword(String userName) async {
    emit(UserLoading());
    try {
      await userService.forgotPassword(userName);
      emit(const OtpSent(otp: ""));
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }

  void resetPassword(Map<String, String> data) async {
    emit(UserLoading());
    try {
      await userService.resetUserPassword(data);
      emit(UserUpdated());
    } catch (e) {
      emit(UserError(errorMsg: e.toString()));
    }
  }
}
