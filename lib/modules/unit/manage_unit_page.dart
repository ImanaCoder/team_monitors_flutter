import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/unit/cubit/unit_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUnitPage extends StatelessWidget {
  ManageUnitPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Name",
            controller: _name,
            validator: sl<MyFormValidator>().required,
          ),
          BlocProvider(
            create: (context) => UnitCubit(),
            child: BlocConsumer<UnitCubit, UnitState>(
              listener: (context, state) {
                if (state is UnitError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is UnitSuccess) {
                  sl<AppToast>().success(state.successMsg);
                  Navigator.pop(context, true);
                }
              },
              builder: (context, state) {
                if (state is UnitLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Save",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {"name": _name.text};
                      context.read<UnitCubit>().addNewUnit(data);
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
