import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/core/token_info.dart';
import 'package:team_monitor/modules/sales-order/cubit/sales_order_cubit.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesOrderDetails extends AppLayout {
  final int orderId;
  final String orderType;
  const SalesOrderDetails({super.key, required this.orderId, required this.orderType});

  @override
  Widget header() => const AppHeader(title: "Sales Order Details");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesOrderCubit()..getOrderDetails(orderId, orderType),
      child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
        listener: (context, state) {
          if (state is SalesOrderError) {
            sl<AppToast>().error(state.errorMsg);
          }
        },
        builder: (context, state) {
          if (state is SalesOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SalesOrderLoaded) {
            var order = state.salesOrder;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Type: ${order['customerType'] == 0 ? 'Individual' : 'Business'}",
                  style: const TextStyle(color: Colors.green, fontSize: 18),
                ),
                _CustomerDetails(order: order),
                _DeliveryAddress(order: order),
                _Products(order: order),
                _DeliveryNote(order: order),
                const SizedBox(height: 5),
                if (sl<TokenInfo>().currentUserRole == "Admin")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const _ActionButton(name: 'Generate Invoice', color: Color(0xFF7D8888)),
                      BlocProvider(
                        create: (context) => SalesOrderCubit(),
                        child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
                          listener: (context, state) {
                            if (state is SalesOrderError) {
                              sl<AppToast>().error(state.errorMsg);
                            } else if (state is SalesOrderSuccess) {
                              order['status'] = 2;
                              sl<AppToast>().success(state.successMsg);
                            }
                          },
                          builder: (context, state) {
                            if (state is SalesOrderLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return order['status'] == 1
                                ? _ActionButton(
                                    name: 'Mark As Complete',
                                    color: const Color(0xFF2D3B8A),
                                    onClick: () {
                                      context.read<SalesOrderCubit>().markOrderAsComplete(order['id']);
                                    },
                                  )
                                : Container();
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _CustomerDetails extends StatelessWidget {
  final dynamic order;
  const _CustomerDetails({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Heading(title: "Customer Details"),
        Text('Name: ${order['customerName']}'),
        Text('Contact: ${order['customerContactNumber']}'),
      ],
    );
  }
}

class _DeliveryAddress extends StatelessWidget {
  final dynamic order;
  const _DeliveryAddress({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Heading(title: "Delivery Address"),
        Text('${order['deliveryAddress']}'),
      ],
    );
  }
}

class _DeliveryNote extends StatelessWidget {
  final dynamic order;
  const _DeliveryNote({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Heading(title: "Delivery Note"),
        Text('${order['deliveryNote']}'),
      ],
    );
  }
}

class _Products extends StatelessWidget {
  final dynamic order;
  const _Products({required this.order});

  List<dynamic> get orderProducts {
    return order['orderProducts'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Heading(title: "Products"),
        Column(
          children: orderProducts.map((op) => _ProductInfo(product: op)).toList(),
        ),
        Text('Total Amount = ${order['totalAmount']}'),
        // Text('COD Amount = 123'),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final dynamic product;
  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('${product['productName']}'),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.green,
            ),
            child: Text(
              '${product['productQuantity']} ${product['unitName']}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 5),
          Text('X ${product['mrp']}'),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String title;
  const _Heading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xFF2D3B8A), fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String name;
  final Color color;
  final void Function()? onClick;
  const _ActionButton({required this.name, required this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }
}
