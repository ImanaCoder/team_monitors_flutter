import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:team_monitor/modules/sales-order/sales_order_list_for_dashboard.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/widgets/confirm_exit.dart';
import '../widgets/dashboard_widgets.dart';

class CoSellerDashboard extends AppLayout {
  const CoSellerDashboard({super.key});

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
      child: Scaffold(
        body: ListView(
          children: const [
            _SalesContainer(),
            SalesOrderListForDashboard(),
            // const _TopProductsContainer(),
          ],
        ),
      ),
    );
  }
}

class _SalesContainer extends StatelessWidget {
  const _SalesContainer();

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      title: "Sales",
      titleSuffix: const Text('Total Sales', style: TextStyle(color: Color(0xFF2D3B8A), fontSize: 17)),
      child: BlocProvider(
        create: (context) => CosellerCubit()..getDashboardInfo(),
        child: BlocConsumer<CosellerCubit, CosellerState>(
          listener: (context, state) {
            if (state is CosellerError) {
              sl<AppToast>().error(state.errorMsg);
            }
          },
          builder: (context, state) {
            if (state is CosellerProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CosellerProfileLoaded) {
              var info = state.coseller;
              return InkWell(
                onTap: () {
                  //
                },
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CountBox(value: info['totalSalesAmount'], text: 'Amount Sales'),
                    CountBox(value: info['totalCustomers'], text: "Customers"),
                    CountBox(value: info['totalSalesOrder'], text: "Orders Created"),
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

class _TopProductsContainer extends StatelessWidget {
  const _TopProductsContainer();

  @override
  Widget build(BuildContext context) {
    return const DashboardContainer(
      title: "Top Selling Product",
      titleSuffix: Icon(Icons.arrow_forward_ios, color: Color(0xFF2D3B8A), size: 14),
      child: Column(
        children: [
          _TopProductInfo(),
          _TopProductInfo(),
          _TopProductInfo(),
        ],
      ),
    );
  }
}

class _TopProductInfo extends StatelessWidget {
  const _TopProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Text('Keratin Hair Treatment & SPA', style: TextStyle(color: Color(0xFF2D3B8A)))),
        Text('Rs. 799', style: TextStyle(color: Color(0xFF2D3B8A))),
      ],
    );
  }
}
