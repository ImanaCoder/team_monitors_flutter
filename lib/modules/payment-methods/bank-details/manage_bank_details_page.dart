import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageBankDetailsPage extends StatelessWidget {
  ManageBankDetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _bankName = TextEditingController();
  final _branchName = TextEditingController();
  final _accountNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Bank Name",
            controller: _bankName,
            validator: sl<MyFormValidator>().required,
          ),
          AppFormField(
            label: "Branch Name",
            controller: _branchName,
            validator: sl<MyFormValidator>().required,
          ),
          AppFormField(
            label: "Account Number",
            controller: _accountNumber,
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
                        "bankName": _bankName.text,
                        "branchName": _branchName.text,
                        "accountNumber": _accountNumber.text,
                      };
                      context.read<CosellerCubit>().addBankDetails(data);
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
