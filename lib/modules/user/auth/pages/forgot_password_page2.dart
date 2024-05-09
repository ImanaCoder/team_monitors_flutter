import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/user/cubit/user_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage2 extends StatelessWidget {
  final String username;
  ForgotPasswordPage2({super.key, required this.username});

  final _formKey = GlobalKey<FormState>();
  final _otpCode = TextEditingController();
  final _password = TextEditingController();

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
                        children: [TextSpan(text: "SMS", style: TextStyle(fontSize: 18, color: Colors.red))],
                      ),
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
                      label: "New Password",
                      validator: sl<MyFormValidator>().required,
                    ),
                    const SizedBox(height: 16),

                    // States & Reset Button
                    BlocProvider(
                      create: (context) => UserCubit(),
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          if (state is UserError) {
                            sl<AppToast>().error(state.errorMsg);
                          } else if (state is UserUpdated) {
                            sl<AppToast>().success('Password Changed Successfully');
                            Navigator.pushNamedAndRemoveUntil(context, '/users/login', (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          // Reset Button
                          return AppButton(
                            name: "Reset",
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                var data = {'UserName': username, 'Password': _password.text, 'Token': _otpCode.text};

                                context.read<UserCubit>().resetPassword(data);
                              }
                            },
                          );
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
