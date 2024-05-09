import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/user/cubit/user_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_page2.dart';

class ForgotPasswordPage1 extends StatelessWidget {
  ForgotPasswordPage1({super.key});

  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      RichText(
                        text: const TextSpan(
                            text: "Reset Your ",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Password",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFF652D90),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ]),
                      ),
                      const Text(
                        "Enter Your Registered Mobile Number",
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 15),
                      AppFormField(
                        controller: _username,
                        label: "Mobile Number",
                        validator: sl<MyFormValidator>().mobileNumber,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 10),
                      //
                      // States & Next Button
                      BlocProvider(
                        create: (context) => UserCubit(),
                        child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserError) {
                              sl<AppToast>().error(state.errorMsg);
                            }
                            // else if (state is NoUserExists) {
                            //   displayToast('No User found with this phone number');
                            // }
                            else if (state is OtpSent) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgotPasswordPage2(username: _username.text),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            // Next Button
                            return AppButton(
                              name: "Next",
                              onPressed: () {
                                if ((_formKey.currentState?.validate() ?? false)) {
                                  context.read<UserCubit>().forgotPassword(_username.text);
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
      ),
    );
  }
}
