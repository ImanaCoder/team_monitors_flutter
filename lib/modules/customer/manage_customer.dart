import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/customer/cubit/customer_cubit.dart';
import 'package:codeal/shared/models/address.dart';
import 'package:codeal/shared/widgets/address_box.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/app_form_fields.dart';

class ManageCustomer extends StatelessWidget {
  ManageCustomer({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _deliveryNote = TextEditingController();
  final _type = TextEditingController(text: "1");
  final _businessName = TextEditingController();
  final _panNumber = TextEditingController();
  final address = Address.empty();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit(),
      child: Column(
        children: [
          BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              if (state is CustomerTypeToggled) {
                _type.text = state.newValue;
                // clearing out unnecessary data when newly selected customer is Individual type
                if (state.newValue == "1") {
                  _businessName.text = "";
                  _panNumber.text = "";
                }
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CustomerTypeBox(name: "Individual", originalValue: "1", currentValue: _type.text),
                  const SizedBox(width: 10),
                  _CustomerTypeBox(name: "Business", originalValue: "2", currentValue: _type.text),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppFormField(
                  controller: _name,
                  label: "Consumer Name",
                  textInputAction: TextInputAction.next,
                ),
                if (_type.text == "2")
                  AppFormField(
                    controller: _businessName,
                    label: "Business Name",
                    textInputAction: TextInputAction.next,
                  ),
                if (_type.text == "2")
                  AppFormField(
                    controller: _panNumber,
                    label: "PAN",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                AppFormField(
                  controller: _contact,
                  label: "Contact Number",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AddressBox(address: address),
                AppFormField(
                  controller: _deliveryNote,
                  label: "Delivery Note",
                  textInputAction: TextInputAction.next,
                ),

                // create customer button
                BlocConsumer<CustomerCubit, CustomerState>(
                  listener: (context, state) {
                    if (state is CustomerError) {
                      sl<AppToast>().error(state.errorMsg);
                    } else if (state is CustomerCreated) {
                      sl<AppToast>().success("Customer Added Successfully");
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is CustomerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AppButton(
                      name: "Create",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          var data = {
                            "name": _name.text,
                            "contactNumber": _contact.text,
                            "businessName": _businessName.text,
                            "panNumber": _panNumber.text,
                            "deliveryNote": _deliveryNote.text,
                            "type": 0,
                            "address": address.toJson(),
                          };
                          context.read<CustomerCubit>().addCustomer(data);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerTypeBox extends StatelessWidget {
  final String name;
  final String originalValue, currentValue;
  const _CustomerTypeBox({required this.name, required this.originalValue, required this.currentValue});

  final color = const Color(0xFF049C2F);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CustomerCubit>().toggleCustomerType(currentValue);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: originalValue == currentValue
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color,
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: color),
              ),
        child: originalValue == currentValue
            ? Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
            : Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
