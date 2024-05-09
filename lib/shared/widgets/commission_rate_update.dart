import 'package:codeal/core/service_locator.dart';
import 'package:codeal/shared/models/commission_rate.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:flutter/material.dart';

class CommissionRateUpdate extends StatelessWidget {
  final CommissionRate commissionRate;
  CommissionRateUpdate({super.key, required this.commissionRate});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Coseller Rate",
            keyboardType: TextInputType.number,
            validator: sl<MyFormValidator>().required,
            onSaved: (value) => commissionRate.cosellerRate = num.parse(value!),
          ),
        ],
      ),
    );
  }
}
