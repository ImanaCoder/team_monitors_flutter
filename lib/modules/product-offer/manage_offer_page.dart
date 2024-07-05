import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/product-offer/cubit/product_offer_cubit.dart';
import 'package:team_monitor/modules/product-offer/models.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product/cubit/product_cubit.dart';

class ManageOfferPage extends StatelessWidget {
  ManageOfferPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final offer = Offer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductOfferCubit(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppFormField(
              label: "Name",
              onSaved: (value) => offer.name = value,
              validator: sl<MyFormValidator>().required,
            ),
            AppFormField(
              label: "Description",
              onSaved: (value) => offer.description = value,
              validator: sl<MyFormValidator>().required,
            ),
            AppFormField(
              label: "From Date",
              onSaved: (value) => offer.fromDate = value,
              keyboardType: TextInputType.datetime,
              validator: sl<MyFormValidator>().required,
            ),
            AppFormField(
              label: "To Date",
              onSaved: (value) => offer.toDate = value,
              keyboardType: TextInputType.datetime,
              validator: sl<MyFormValidator>().required,
            ),
            AppFormField(
              label: "Package Count",
              onSaved: (value) => offer.packageCount = num.parse(value ?? '0'),
              keyboardType: TextInputType.number,
              validator: sl<MyFormValidator>().required,
            ),
            _AddProductArea(offer: offer),
            const SizedBox(height: 10),
            BlocConsumer<ProductOfferCubit, ProductOfferState>(
              listener: (context, state) {
                if (state is ProductOfferError) {
                  sl<AppToast>().error(state.errorMsg);
                } else if (state is ProductOfferSuccess) {
                  sl<AppToast>().success(state.successMsg);
                  Navigator.pop(context, true);
                }
              },
              builder: (context, state) {
                if (state is ProductOfferLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AppButton(
                  name: "Save",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      context.read<ProductOfferCubit>().addNewOffer(offer.toJson());
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

class _DiscountBox extends StatelessWidget {
  final Offer offer;
  const _DiscountBox({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Text('Discount'),
              const SizedBox(width: 10),
              AppSwichInput(
                activeText: "Percent",
                inActiveText: "Flat",
                isActive: offer.discountType == "Percent",
                onSwitch: () {
                  var temp = offer.discountFlat;
                  offer.discountFlat = offer.discountPercent;
                  offer.discountPercent = temp;
                  offer.switchDiscountType();
                  context.read<ProductOfferCubit>().refreshProductOfferInfo();
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        TinyTextbox(onChanged: (value) {
          if (offer.discountType == "Percent") {
            offer.discountPercent = num.parse(value ?? '0');
          } else {
            offer.discountFlat = num.parse(value ?? '0');
          }
          // context.read<ProductOfferCubit>().refreshSalesOrderInfo();
        }),
      ],
    );
  }
}

class _AddProductArea extends StatefulWidget {
  final Offer offer;
  const _AddProductArea({required this.offer});

  @override
  State<_AddProductArea> createState() => _AddProductAreaState();
}

class _AddProductAreaState extends State<_AddProductArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider<ProductCubit>(create: (context) => ProductCubit()..getAllProductsByCompany()),
            BlocProvider(create: (context) => ProductOfferCubit())
          ],
          child: Column(
            children: [
              // Product Search & Add To Order
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductError) sl<AppToast>().error(state.errorMsg);
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductListLoaded) {
                    return AppSearchableDropdown(
                      labelText: 'Find Product',
                      keyString: 'name',
                      items: state.products,
                      onChanged: (item) =>
                          context.read<ProductOfferCubit>().addProductToOffer(widget.offer.offerProducts, item),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              // Show current products, quantity increment/decrement, sub-total, discount etc
              BlocConsumer<ProductOfferCubit, ProductOfferState>(
                listener: (context, state) => {if (state is ProductOfferError) sl<AppToast>().error(state.errorMsg)},
                builder: (context, state) {
                  if (state is ProductAddedToOffer) {
                    widget.offer.offerProducts.add(OfferProduct(product: state.product));
                  } else if (state is ProductRemovedFromOffer) {
                    widget.offer.offerProducts.remove(state.product);
                  }
                  return Column(
                    children: [
                      Column(
                        children: widget.offer.offerProducts.map((item) => _ProductInfo(offerProduct: item)).toList(),
                      ),
                      // _AmountBox(title: const Text('Sub Total (Rs.)'), amount: Text('${widget.order.subTotal}')),
                      _DiscountBox(offer: widget.offer),
                      // _DeliveryBox(order: widget.order),
                      // _AmountBox(title: const Text('Total Amunt'), amount: Text('${widget.order.grandTotal}')),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final OfferProduct offerProduct;
  const _ProductInfo({required this.offerProduct});

  final color = const Color(0xFF2D3B8A);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('${offerProduct.product['name']}')),
          const SizedBox(width: 10),
          Row(
            children: [
              AppSwichInput(
                activeText: "Main",
                inActiveText: "Surplus",
                isActive: offerProduct.type == "Main",
                onSwitch: () {
                  offerProduct.switchProductType();
                  context.read<ProductOfferCubit>().refreshProductOfferInfo();
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  offerProduct.quantity--;
                  context.read<ProductOfferCubit>().refreshProductOfferInfo();
                },
                child: Icon(Icons.remove_circle, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Text('${offerProduct.quantity}', style: TextStyle(color: color)),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  offerProduct.quantity++;
                  context.read<ProductOfferCubit>().refreshProductOfferInfo();
                },
                child: Icon(Icons.add_circle, color: color, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
