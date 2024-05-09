import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/product-offer/cubit/product_offer_cubit.dart';
import 'package:codeal/modules/product-offer/manage_offer_page.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/shared/widgets/app_buttons.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/shared/widgets/app_header.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:codeal/utils/constants.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferListingPage extends AppLayout {
  const OfferListingPage({super.key});

  @override
  bool get applyPaddingToContent => false;

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductOfferCubit()..getAllOffersByCompany(),
      child: Column(
        children: [
          // Header
          AppHeader(
            title: "Offers",
            actions: [
              BlocBuilder<ProductOfferCubit, ProductOfferState>(
                builder: (context, state) {
                  return AddNewHeaderAction(onTap: () async {
                    var res = await showAppDialogBox(context: context, title: "New Offer", content: ManageOfferPage());
                    if (res != null && res == true && context.mounted) {
                      context.read<ProductOfferCubit>().getAllOffersByCompany();
                    }
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: sl<AppConstants>().appPadding,
              child: BlocConsumer<ProductOfferCubit, ProductOfferState>(
                listener: (context, state) {
                  if (state is ProductOfferError) sl<AppToast>().error(state.errorMsg);
                },
                builder: (context, state) {
                  if (state is ProductOfferLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductOfferListLoaded) {
                    var offers = state.offers;
                    if (offers.isEmpty) return const Center(child: Text('No Offers Found'));

                    return ListView(
                      children: offers.map((offer) {
                        return ListTile(
                          title: Text("${offer['name']}"),
                          subtitle: Text("${offer['fromDate']} to ${offer['toDate']}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              showAppDialogBox(
                                context: context,
                                title: "Update Commission Rate",
                                content: _UpdateCommissionRate(offerId: offer['id']),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateCommissionRate extends StatelessWidget {
  final int offerId;
  _UpdateCommissionRate({required this.offerId});

  final _formKey = GlobalKey<FormState>();
  final _cosellerRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductOfferCubit()..getCommissionRate(offerId),
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
            BlocConsumer<ProductOfferCubit, ProductOfferState>(
              listener: (context, state) {
                if (state is ProductOfferError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is CommissionRateLoaded) {
                  var rate = state.commissionRate;
                  if (rate.runtimeType != String) {
                    _cosellerRate.text = "${rate['coSellerRate']}";
                  }
                } else if (state is CommissionRateUpdated) {
                  sl<AppToast>().success("Commission Rate Updated");
                  Navigator.pop(context, true);
                }
              },
              builder: (context, state) {
                if (state is ProductOfferLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Update",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      var data = {'coSellerRate': _cosellerRate.text, 'status': 1};
                      context.read<ProductOfferCubit>().addCommissionRateToOffer(offerId, data);
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
