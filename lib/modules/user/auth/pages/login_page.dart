import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/user/auth/pages/forgot_password_page1.dart';
import 'package:codeal/modules/user/cubit/user_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _password = TextEditingController();

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
                      const Text(
                        "Login your account",
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 15),
                      AppFormField(
                        controller: _userName,
                        label: "User Name",
                        validator: sl<MyFormValidator>().mobileNumber,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      AppPasswordField(passController: _password),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage1()));
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                      //
                      // States & Login Button
                      BlocProvider(
                        create: (context) => UserCubit(),
                        child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserError) {
                              sl<AppToast>().error(state.errorMsg);
                            } else if (state is UserLoggedIn) {
                              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return AppButton(
                              name: "Login",
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  var data = {"userName": _userName.text, "password": _password.text};
                                  context.read<UserCubit>().loginUser(data);
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
