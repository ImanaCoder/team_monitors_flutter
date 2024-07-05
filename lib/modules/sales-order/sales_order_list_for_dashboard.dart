import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/sales-order/cubit/sales_order_cubit.dart';
import 'package:team_monitor/modules/sales-order/sales_order_list_tile.dart';
import 'package:team_monitor/modules/user/home/widgets/dashboard_widgets.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesOrderListForDashboard extends StatelessWidget {
  const SalesOrderListForDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      title: "Sales Orders",
      titleSuffix: const Icon(Icons.arrow_forward_ios, color: Color(0xFF2D3B8A), size: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Row(
          //   children: [
          //     Expanded(child: _ProductStatus(title: 'New Product', color: Colors.red)),
          //     SizedBox(width: 5),
          //     Expanded(child: _ProductStatus(title: 'Shipped', color: Colors.yellow)),
          //     SizedBox(width: 5),
          //     Expanded(child: _ProductStatus(title: 'Delivered', color: Colors.green)),
          //   ],
          // ),
          // const SizedBox(height: 5),
          BlocProvider(
            create: (context) => SalesOrderCubit()..getAllSalesOrders(limit: 3),
            child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
              listener: (context, state) {
                if (state is SalesOrderError) {
                  sl<AppToast>().error(state.errorMsg);
                }
              },
              builder: (context, state) {
                if (state is SalesOrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SalesOrderListLoaded) {
                  var orders = state.salesOrders;
                  if (orders.isEmpty) {
                    return const Center(child: Text('No Sales Orders'));
                  }

                  return Column(
                    children: orders.map((o) => SalesOrderListTile(order: o)).toList(),
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ProductStatus extends StatelessWidget {
  final String title;
  final Color color;
  const _ProductStatus({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
