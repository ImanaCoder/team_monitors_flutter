import 'package:codeal/modules/company/cubit/company_cubit.dart';
import 'package:codeal/shared/models/address.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/address_box.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/shared/widgets/app_header.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../utils/display_toast.dart';

class UpdateCompany extends AppLayout {
  UpdateCompany({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _ownerName = TextEditingController();
  final _panNumber = TextEditingController();
  final _email = TextEditingController();
  final _website = TextEditingController();
  final _supportLineNumber = TextEditingController();
  final _addressId = TextEditingController();
  final address = Address.empty();

  @override
  Widget header() => const AppHeader(title: "Update Company Info");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (_) => CompanyCubit()..getCompanyProfile(),
      child: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is CompanyError) {
            sl<AppToast>().error(state.errorMsg);
          } else if (state is CompanySuccess) {
            sl<AppToast>().success(state.successMsg);
            Navigator.pop(context);
          } else if (state is CompanyProfileLoaded) {
            var company = state.company;
            _name.text = company['name'] ?? "";
            _contact.text = company['contactNumber'] ?? "";
            _ownerName.text = company['ownerName'] ?? "";
            _panNumber.text = company['panNumber'] ?? "";
            _email.text = company['email'] ?? "";
            _website.text = company['website'] ?? "";
            _supportLineNumber.text = company['supportLineNumber'] ?? "";
            _addressId.text = company['addressId'] != null ? company['addressId'].toString() : "";
            if (company['address'] != null) address.fillDataFromJson(company['address']);
          }
        },
        builder: (context, state) {
          if (state is CompanyProfileLoading || state is CompanyInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                AppFormField(
                  controller: _name,
                  label: "Company Name",
                  validator: sl<MyFormValidator>().required,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _ownerName,
                  label: "Owner Name",
                  validator: sl<MyFormValidator>().required,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _contact,
                  label: "Contact Number",
                  validator: sl<MyFormValidator>().mobileNumber,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _panNumber,
                  label: "PAN",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _email,
                  label: "Email",
                  validator: sl<MyFormValidator>().email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _website,
                  label: "Website",
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _supportLineNumber,
                  label: "Support Line Number",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AddressBox(address: address),
                BlocBuilder<CompanyCubit, CompanyState>(
                  builder: (context, state) {
                    if (state is CompanyLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AppButton(
                      name: "Update",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          var data = {
                            "name": _name.text,
                            "panNumber": _panNumber.text,
                            "ownerName": _ownerName.text,
                            "contactNumber": _contact.text,
                            "email": _email.text,
                            "website": _website.text,
                            "supportLineNumber": _supportLineNumber.text,
                            "addressId": _addressId.text != '' ? _addressId.text : null,
                            "address": address.toJson(),
                          };
                          context.read<CompanyCubit>().updateCompany(data);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
