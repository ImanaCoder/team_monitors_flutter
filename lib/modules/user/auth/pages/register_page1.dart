import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/user/cubit/user_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/constants.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_page2.dart';

class RegisterPageOne extends StatelessWidget {
  RegisterPageOne({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      const Text("Get Started", style: TextStyle(fontSize: 22)),
                      const SizedBox(height: 25),
                      const Text("Enter Your Details Below", style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 5),
                      AppFormField(
                        controller: _name,
                        label: "Full Name",
                        validator: sl<MyFormValidator>().required,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      AppFormField(
                        controller: _username,
                        label: "Contact Number",
                        validator: sl<MyFormValidator>().mobileNumber,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 10),
                      // States & Next Button
                      BlocProvider(
                        create: (context) => UserCubit(),
                        child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserError) {
                              sl<AppToast>().error(state.errorMsg);
                            }
                            // else if (state is UserExists) {
                            //   displayToast('This user already exists. Please use different phone number');
                            // }
                            else if (state is OtpSent) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterPageTwo(
                                    username: _username.text,
                                    name: _name.text,
                                    otp: state.otp,
                                  ),
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
                              name: 'Continue',
                              onPressed: () {
                                if ((_formKey.currentState?.validate() ?? false)) {
                                  context.read<UserCubit>().sendOtp(_username.text);
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
              // Login Page Redirection Button
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Text('LOGIN', style: TextStyle(color: sl<AppConstants>().appColor)),
              ),
              const SizedBox(height: 15),
              const Text('Give A Call'),
              RichText(
                text: const TextSpan(
                  text: "Support Hot line ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "9826300088",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
