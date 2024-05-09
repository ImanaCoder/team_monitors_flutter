import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/product/cubit/product_cubit.dart';
import 'package:codeal/modules/unit/unit_service.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/shared/widgets/app_header.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:codeal/shared/widgets/value_selector.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductPage extends AppLayout {
  ManageProductPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _unitId = TextEditingController();
  final _batchNumber = TextEditingController();
  final _mrp = TextEditingController();
  final _stockQty = TextEditingController();

  @override
  Widget header() => const AppHeader(title: "Add New Product");

  @override
  Widget content(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            label: "Name",
            controller: _name,
            validator: sl<MyFormValidator>().required,
            textInputAction: TextInputAction.next,
          ),
          // AppFormField(
          //   label: "Unit",
          //   controller: _unitId,
          //   validator: sl<MyFormValidator>().required,
          //   keyboardType: TextInputType.number,
          //   textInputAction: TextInputAction.next,
          // ),
          ValueSelector(
            label: "Unit",
            controller: _unitId,
            textColumn: "name",
            future: sl<UnitService>().getActiveUnits(),
          ),
          AppFormField(
            label: "Batch Number",
            controller: _batchNumber,
            validator: sl<MyFormValidator>().required,
            textInputAction: TextInputAction.next,
          ),
          AppFormField(
            label: "MRP",
            controller: _mrp,
            validator: sl<MyFormValidator>().required,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          AppFormField(
            label: "Stock Quantity",
            controller: _stockQty,
            validator: sl<MyFormValidator>().required,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          AppFormField(
            label: "Description",
            maxLines: null,
            controller: _description,
            textInputAction: TextInputAction.done,
          ),

          // Actions
          BlocProvider(
            create: (context) => ProductCubit(),
            child: BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is ProductError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is ProductSuccess) {
                  sl<AppToast>().success(state.successMsg);
                  Navigator.pop(context, true);
                }
              },
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Add",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {
                        "name": _name.text,
                        "description": _description.text,
                        "unitId": _unitId.text,
                        "batchNumber": _batchNumber.text,
                        "mrp": _mrp.text,
                        "stockQuantity": _stockQty.text,
                      };
                      context.read<ProductCubit>().addNewProduct(data);
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
