import 'package:team_monitor/core/navigation_service.dart';
import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/company/cubit/company_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/app_form_fields.dart';

class AddCompany extends AppLayout {
  AddCompany({super.key});

  final _formKey = GlobalKey<FormState>();
  final _companyName = TextEditingController();
  final _contactNumber = TextEditingController();
  final _panNumber = TextEditingController();

  @override
  Widget header() => const AppHeader(title: "Add Company");

  @override
  Widget content(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            controller: _companyName,
            label: "Company Name",
            validator: sl<MyFormValidator>().required,
            textInputAction: TextInputAction.next,
          ),
          AppFormField(
            controller: _contactNumber,
            label: "Contact Number",
            validator: sl<MyFormValidator>().mobileNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          AppFormField(
            controller: _panNumber,
            label: "PAN",
            validator: sl<MyFormValidator>().required,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),

          // create customer button
          BlocProvider(
            create: (context) => CompanyCubit(),
            child: BlocConsumer<CompanyCubit, CompanyState>(
              listener: (context, state) {
                if (state is CompanyError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is CompanySuccess) {
                  sl<AppToast>().success(state.successMsg);
                  sl<NavigationService>().navigateToDashboard();
                }
              },
              builder: (context, state) {
                if (state is CompanyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Create",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {
                        "companyName": _companyName.text,
                        "contactNumber": _contactNumber.text,
                        "panNumber": _panNumber.text,
                      };
                      context.read<CompanyCubit>().addCompany(data);
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
