import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/sales-order/cubit/sales_order_cubit.dart';
import 'package:codeal/modules/sales-order/sales_order_list_tile.dart';
import 'package:codeal/shared/widgets/app_header.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesOrderListingPage extends AppLayout {
  const SalesOrderListingPage({super.key});

  @override
  Widget header() => const AppHeader(title: "Sales Order Listing");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesOrderCubit()..getAllSalesOrders(),
      child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
        listener: (context, state) {
          if (state is SalesOrderError) sl<AppToast>().error(state.errorMsg);
        },
        builder: (context, state) {
          if (state is SalesOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SalesOrderListLoaded) {
            var orders = state.salesOrders;
            if (orders.isEmpty) return const Center(child: Text('No sales orders Found'));

            return ListView(
              children: orders.map((order) {
                return SalesOrderListTile(order: order);
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
