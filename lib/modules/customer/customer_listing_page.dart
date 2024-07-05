import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/customer/cubit/customer_cubit.dart';
import 'package:team_monitor/modules/customer/customer_details.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerListingPage extends AppLayout {
  const CustomerListingPage({super.key});

  @override
  Widget header() => const AppHeader(title: "Customer Listing");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit()..getAllCustomersByCoSeller(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is CustomerError) sl<AppToast>().error(state.errorMsg);
        },
        builder: (context, state) {
          if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerListLoaded) {
            var customers = state.customers;
            if (customers.isEmpty) return const Center(child: Text('No customers Found'));

            return ListView(
              children: customers.map((customer) {
                return ListTile(
                  title: Text("${customer['name']}"),
                  subtitle: Text("${customer['contactNumber']}"),
                  onTap: () {
                    showAppDialogBox(
                      context: context,
                      title: "Customer Details",
                      content: CustomerDetails(customerId: customer['id']),
                    );
                  },
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
