import 'package:codeal/modules/co-seller/cubit/coseller_cubit.dart';
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

class CosellerUpdatePage extends AppLayout {
  CosellerUpdatePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _panNumber = TextEditingController();
  final _addressId = TextEditingController();
  final address = Address.empty();

  @override
  Widget header() => const AppHeader(title: "Update Profile Info");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (_) => CosellerCubit()..getCosellerProfile(),
      child: BlocConsumer<CosellerCubit, CosellerState>(
        listener: (context, state) {
          if (state is CosellerError) {
            sl<AppToast>().error(state.errorMsg);
          } else if (state is CosellerSuccess) {
            sl<AppToast>().success(state.successMsg);
            Navigator.pop(context);
          } else if (state is CosellerProfileLoaded) {
            var coseller = state.coseller;
            _name.text = coseller['name'] ?? "";
            _panNumber.text = coseller['panNumber'] ?? "";
            _addressId.text = coseller['addressId'] != null ? coseller['addressId'].toString() : "";
            if (coseller['address'] != null) address.fillDataFromJson(coseller['address']);
          }
        },
        builder: (context, state) {
          if (state is CosellerProfileLoading || state is CosellerInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                AppFormField(
                  controller: _name,
                  label: "Name",
                  validator: sl<MyFormValidator>().required,
                  textInputAction: TextInputAction.next,
                ),
                AppFormField(
                  controller: _panNumber,
                  label: "PAN",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AddressBox(address: address),
                BlocBuilder<CosellerCubit, CosellerState>(
                  builder: (context, state) {
                    if (state is CosellerLoading) {
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
                            "addressId": _addressId.text != '' ? _addressId.text : null,
                            "address": address.toJson(),
                          };
                          context.read<CosellerCubit>().updateCoseller(data);
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
