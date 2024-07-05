import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/company/cubit/company_cubit.dart';
import 'package:team_monitor/modules/sales-order/sales_order_list_for_dashboard.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/widgets/confirm_exit.dart';
import '../widgets/dashboard_widgets.dart';

class AdminDashboard extends AppLayout {
  const AdminDashboard({super.key});

  @override
  Widget userInfo() => const UserInfoStack();

  @override
  Widget content(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        confirmExit(context);
      },
      child: ListView(
        children: const [
          _SalesContainer(),
          SalesOrderListForDashboard(),
        ],
      ),
    );
  }
}

class _SalesContainer extends StatelessWidget {
  const _SalesContainer();

  final totalSalesAmount = 145000;
  final totalSalesAgent = 4580;
  final totalCustomers = 1580;
  final totalOrderCreated = 1345;

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      title: "Sales",
      titleSuffix: const Text('Total Sales', style: TextStyle(color: Color(0xFF2D3B8A), fontSize: 17)),
      child: BlocProvider(
        create: (context) => CompanyCubit()..getDashboardInfo(),
        child: BlocConsumer<CompanyCubit, CompanyState>(
          listener: (context, state) {
            if (state is CompanyError) {
              sl<AppToast>().error(state.errorMsg);
            }
          },
          builder: (context, state) {
            if (state is CompanyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompanyDashboardInfoLoaded) {
              var info = state.info;
              return InkWell(
                onTap: () {
                  //
                },
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CountBox(value: info['totalCoSellers'], text: 'Co-Sellers'),
                    CountBox(value: info['totalOrders'], text: "Sales Orders"),
                    CountBox(value: info['totalItemSold'], text: "Products Sold"),
                    CountBox(value: info['totalCommissionPaid'], text: "Commission Paid"),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
