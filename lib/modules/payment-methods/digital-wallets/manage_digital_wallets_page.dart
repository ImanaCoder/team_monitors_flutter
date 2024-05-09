import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageDigitalWalletsPage extends StatelessWidget {
  ManageDigitalWalletsPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _walletName = TextEditingController();
  final _walletId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Wallet Name",
            controller: _walletName,
            validator: sl<MyFormValidator>().required,
          ),
          AppFormField(
            label: "Wallet Id",
            controller: _walletId,
            validator: sl<MyFormValidator>().required,
          ),
          BlocProvider(
            create: (context) => CosellerCubit(),
            child: BlocConsumer<CosellerCubit, CosellerState>(
              listener: (context, state) {
                if (state is CosellerError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is CosellerSuccess) {
                  sl<AppToast>().success(state.successMsg);
                  Navigator.pop(context, true);
                }
              },
              builder: (context, state) {
                if (state is CosellerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Save",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {
                        "walletName": _walletName.text,
                        "walletId": _walletId.text,
                      };
                      context.read<CosellerCubit>().addDigitalWallet(data);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
