import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/product-offer/cubit/product_offer_cubit.dart';
import 'package:codeal/modules/sales-order/models.dart';
import 'package:codeal/shared/widgets/app_form_fields.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product/cubit/product_cubit.dart';
import 'cubit/sales_order_cubit.dart';

class BoxLayout extends StatelessWidget {
  final Widget child;
  const BoxLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: const Color(0xFFD9D9D9)),
      ),
      child: child,
    );
  }
}

class AddOfferToOrder extends StatelessWidget {
  final Order order;
  const AddOfferToOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BoxLayout(
      child: Column(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<ProductOfferCubit>(
                create: (context) => ProductOfferCubit()..getCompanyOffersForPublic(order.companyId ?? 0),
              ),
              BlocProvider(create: (context) => SalesOrderCubit())
            ],
            child: Column(
              children: [
                // Offer search and Add to order
                BlocConsumer<ProductOfferCubit, ProductOfferState>(
                  listener: (context, state) {
                    if (state is ProductOfferError) sl<AppToast>().error(state.errorMsg);
                  },
                  builder: (context, state) {
                    if (state is ProductOfferLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductOfferListLoaded) {
                      return AppSearchableDropdown(
                        labelText: 'Find Offer',
                        keyString: 'name',
                        items: state.offers,
                        onChanged: (item) => context.read<SalesOrderCubit>().addOfferToOrder(order, item),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                // Show current products, quantity increment/decrement
                BlocConsumer<SalesOrderCubit, SalesOrderState>(
                  listener: (context, state) => {if (state is SalesOrderError) sl<AppToast>().error(state.errorMsg)},
                  builder: (context, state) {
                    // if (state is SalesOrderSuccess) {
                    //   order.offer = state.product;
                    // } else if (state is ProductRemovedFromOrder) {
                    //   order.offer = null;
                    //   order.offerId = null;
                    // }
                    if (order.offer != null) {
                      return Column(
                        children: [
                          _AmountBox(title: Text("${order.offer['name']}"), amount: Text('${order.offer['amount']}')),
                          _AmountBox(title: const Text('Sub Total (Rs.)'), amount: Text('${order.subTotalForOffer}')),
                          // _DiscountBox(order: order),
                          _DeliveryBox(order: order),
                          _AmountBox(title: const Text('Total Amunt'), amount: Text('${order.grandTotalForOffer}')),
                        ],
                      );
                    }
                    return Container();
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

class AddProductArea extends StatelessWidget {
  final Order order;
  const AddProductArea({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BoxLayout(
      child: Column(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<ProductCubit>(
                create: (context) => ProductCubit()..getCompanyProductsForPublic(order.companyId ?? 2),
              ),
              BlocProvider(create: (context) => SalesOrderCubit())
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
                            context.read<SalesOrderCubit>().addProductToOrder(order.orderProducts, item),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                // Show current products, quantity increment/decrement
                BlocConsumer<SalesOrderCubit, SalesOrderState>(
                  listener: (context, state) => {if (state is SalesOrderError) sl<AppToast>().error(state.errorMsg)},
                  builder: (context, state) {
                    if (state is ProductAddedToOrder) {
                      order.orderProducts.add(OrderProduct(product: state.product));
                    } else if (state is ProductRemovedFromOrder) {
                      order.orderProducts.remove(state.product);
                    }
                    return Column(
                      children: [
                        Column(
                          children: order.orderProducts.map((item) => _ProductInfo(orderProduct: item)).toList(),
                        ),
                        // payment info
                        _AmountBox(title: const Text('Sub Total (Rs.)'), amount: Text('${order.subTotal}')),
                        _DiscountBox(order: order),
                        _DeliveryBox(order: order),
                        _AmountBox(title: const Text('Total Amunt'), amount: Text('${order.grandTotal}')),
                      ],
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

class _ProductInfo extends StatelessWidget {
  final OrderProduct orderProduct;
  const _ProductInfo({required this.orderProduct});

  final color = const Color(0xFF2D3B8A);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('${orderProduct.product['name']}')),
          const SizedBox(width: 10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  orderProduct.quantity--;
                  context.read<SalesOrderCubit>().refreshSalesOrderInfo();
                },
                child: Icon(Icons.remove_circle, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Text('${orderProduct.quantity}', style: TextStyle(color: color)),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  orderProduct.quantity++;
                  context.read<SalesOrderCubit>().refreshSalesOrderInfo();
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

class _AmountBox extends StatelessWidget {
  final Widget title;
  final Widget amount;
  const _AmountBox({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: title),
        amount,
      ],
    );
  }
}

class _DiscountBox extends StatelessWidget {
  final Order order;
  const _DiscountBox({required this.order});

  @override
  Widget build(BuildContext context) {
    return _AmountBox(
      title: Row(
        children: [
          const Text('Discount'),
          AppSwichInput(
            activeText: "Percent",
            inActiveText: "Flat",
            isActive: order.discountType == "Percent",
            onSwitch: () {
              var temp = order.discountFlat;
              order.discountFlat = order.discountPercent;
              order.discountPercent = temp;
              order.switchDiscountType();
              context.read<SalesOrderCubit>().refreshSalesOrderInfo();
            },
          ),
          const SizedBox(width: 10),
          TinyTextbox(onChanged: (value) {
            if (value == '') value = '0';
            if (order.discountType == "Percent") {
              order.discountPercent = num.parse(value ?? '0');
            } else {
              order.discountFlat = num.parse(value ?? '0');
            }
            context.read<SalesOrderCubit>().refreshSalesOrderInfo();
          }),
        ],
      ),
      amount: Text('${order.totalDiscount}'),
    );
  }
}

class _DeliveryBox extends StatelessWidget {
  final Order order;
  const _DeliveryBox({required this.order});

  @override
  Widget build(BuildContext context) {
    return _AmountBox(
      title: Row(
        children: [
          const Text('Delivery Charge'),
          const SizedBox(width: 10),
          TinyTextbox(onChanged: (value) {
            if (value == '') value = '0';
            order.deliveryCharge = num.parse(value ?? '0');
            context.read<SalesOrderCubit>().refreshSalesOrderInfo();
          }),
        ],
      ),
      amount: Text('${order.deliveryCharge}'),
    );
  }
}
