import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/helpers/color_extension.dart';
import 'package:team_monitor/modules/user/auth/pages/login_page.dart';
import 'package:team_monitor/modules/user/cubit/user_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/shared/widgets/gradient_text.dart';
import 'package:team_monitor/shared/widgets/small_gradient_button.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:team_monitor/utils/display_toast.dart';

import 'register_page2.dart';

class RegisterPageOne extends StatelessWidget {
  RegisterPageOne({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _companyName = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/svg/logo.png',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 30),
                  GradientText(
                    'Register Your Company in Team Monitor',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    gradientColors: TeamMonitorColor.primaryG,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppFormField(
                          controller: _name,
                          label: "Full Name",
                          validator: sl<MyFormValidator>().required,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        AppFormField(
                          controller: _email,
                          label: "Email",
                          validator: sl<MyFormValidator>().email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        AppFormField(
                          controller: _companyName,
                          label: "Name of the Company",
                          validator: sl<MyFormValidator>().required,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 30),
                        BlocProvider(
                          create: (context) => UserCubit(),
                          child: BlocConsumer<UserCubit, UserState>(
                            listener: (context, state) {
                              if (state is UserError) {
                                sl<AppToast>().error(state.errorMsg);
                              } else if (state is OtpSent) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterPageTwo(
                                      username: _email.text,
                                      name: _name.text,
                                      otp: state.otp,
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is UserLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Center(
                                child: SmallGradientButton(
                                  buttonText: 'Continue',
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context
                                          .read<UserCubit>()
                                          .sendOtp(_email.text);
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
                        Text("Already have an account?",
                            style: TextStyle(
                                color: TeamMonitorColor.gray,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            'Sign-In',
                            style: TextStyle(
                                color: TeamMonitorColor.primaryColor2,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
