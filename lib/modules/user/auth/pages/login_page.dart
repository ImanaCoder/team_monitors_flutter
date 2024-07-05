import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/helpers/color_extension.dart';
import 'package:team_monitor/modules/user/auth/pages/forgot_password_page1.dart';
import 'package:team_monitor/modules/user/auth/pages/register_page1.dart';
import 'package:team_monitor/modules/user/cubit/user_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/shared/widgets/gradient_button.dart';
import 'package:team_monitor/shared/widgets/gradient_text.dart';
import 'package:team_monitor/shared/widgets/small_gradient_button.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/svg/logo.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                GradientText(
                  'Login into Team Monitor',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                  gradientColors: TeamMonitorColor.primaryG,
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      AppFormField(
                        controller: _email,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: sl<MyFormValidator>().email,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      AppPasswordField(passController: _password),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForgotPasswordPage1()));
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocProvider(
                        create: (context) => UserCubit(),
                        child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserError) {
                              sl<AppToast>().error(state.errorMsg);
                            } else if (state is UserLoggedIn) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/dashboard', (route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Center(
                              child: SmallGradientButton(
                                buttonText: "Login",
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    var data = {
                                      "email": _email.text,
                                      "password": _password.text
                                    };
                                    context.read<UserCubit>().loginUser(data);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?",
                        style: TextStyle(
                            color: TeamMonitorColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPageOne()),
                        );
                      },
                      child: Text(
                        'Sign-Up',
                        style: TextStyle(
                            color: TeamMonitorColor.primaryColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
