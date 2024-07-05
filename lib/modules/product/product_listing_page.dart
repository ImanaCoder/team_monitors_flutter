import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/product/cubit/product_cubit.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingPage extends AppLayout {
  const ProductListingPage({super.key});

  @override
  Widget header() => const AppHeader(title: "Product Listing");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProductsByCompany(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductError) sl<AppToast>().error(state.errorMsg);
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            var products = state.products;
            if (products.isEmpty) return const Center(child: Text('No products Found'));

            return ListView(
              children: products.map((product) {
                return ListTile(
                  title: Text("${product['name']} (Rs. ${product['mrp']})"),
                  subtitle: Text("${product['description']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showAppDialogBox(
                        context: context,
                        title: "Update Commission Rate",
                        content: _UpdateCommissionRate(productId: product['id']),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _UpdateCommissionRate extends StatelessWidget {
  final int productId;
  _UpdateCommissionRate({required this.productId});

  final _formKey = GlobalKey<FormState>();
  final _cosellerRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getCommissionRate(productId),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppFormField(
              label: "Coseller Rate",
              keyboardType: TextInputType.number,
              validator: sl<MyFormValidator>().required,
              controller: _cosellerRate,
            ),
            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is ProductError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is CommissionRateLoaded) {
                  var rate = state.commissionRate;
                  if (rate.runtimeType != String) {
                    _cosellerRate.text = "${rate['coSellerRate']}";
                  }
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
                  name: "Update",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {'coSellerRate': _cosellerRate.text, 'status': 1};
                      context.read<ProductCubit>().addCommissionRateToProduct(productId, data);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
