import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/user/cubit/user_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageTwo extends StatelessWidget {
  final String username, name, otp;
  RegisterPageTwo({super.key, required this.username, required this.name, required this.otp});

  final _formKey = GlobalKey<FormState>();
  final _otpCode = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text('Verify Number', style: TextStyle(fontSize: 22)),
                    const Text('Find Your Message From', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                          text: "Mobile Message / ",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          children: [TextSpan(text: "SMS", style: TextStyle(fontSize: 18, color: Colors.red))]),
                    ),
                    const SizedBox(height: 15),
                    //
                    AppFormField(
                      controller: _otpCode,
                      label: "Verification Code",
                      validator: sl<MyFormValidator>().required,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    AppFormField(
                      controller: _password,
                      label: "Create New Password",
                      validator: sl<MyFormValidator>().required,
                    ),
                    AppFormField(
                      controller: _confirmPassword,
                      label: "Confirm New Password",
                      validator: sl<MyFormValidator>().required,
                    ),
                    const SizedBox(height: 16),

                    // States & Regiser Button
                    BlocProvider(
                      create: (context) => UserCubit(),
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          if (state is UserError) {
                            sl<AppToast>().error(state.errorMsg);
                          } else if (state is UserRegistered) {
                            sl<AppToast>().success('User Registered. Please login');
                            Navigator.pushNamedAndRemoveUntil(context, '/users/login', (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          // Register Button
                          return AppButton(
                              name: "Register",
                              onPressed: () {
                                if (_password.text != _confirmPassword.text) {
                                  sl<AppToast>().error('Password and Confirm Password Must Be Same');
                                  return;
                                }
                                if (_otpCode.text != otp) {
                                  sl<AppToast>().error('verification code do not match');
                                  return;
                                }
                                if (!(_formKey.currentState?.validate() ?? false)) {
                                  sl<AppToast>().error('Form invalid');
                                  return;
                                }

                                var data = {
                                  'UserName': username,
                                  'Name': name,
                                  'Password': _password.text,
                                  'ConfirmPassowrd': _confirmPassword.text,
                                };
                                context.read<UserCubit>().registerAsCoSeller(data);
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
