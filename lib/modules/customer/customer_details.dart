import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/customer/cubit/customer_cubit.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetails extends StatelessWidget {
  final int customerId;
  const CustomerDetails({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocProvider(
        create: (context) => CustomerCubit()..getCustomerDetails(customerId),
        child: BlocConsumer<CustomerCubit, CustomerState>(
          listener: (context, state) {
            if (state is CustomerError) {
              sl<AppToast>().error(state.errorMsg);
            }
          },
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoaded) {
              var customer = state.customer;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${customer['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  Text('Customer ID ${customer['id']}', style: const TextStyle(color: Color(0xFF7D8888))),
                  const SizedBox(height: 5),
                  // -----------------------------------------------------
                  const _Heading(text: 'Personal Information'),
                  _InfoText(text: "Assign Co-Seller ID", value: '${customer['coSellerId']}'),
                  _InfoText(text: "Assign Co-Seller Name", value: '${customer['coSellerName']}'),
                  const _InfoText(text: "Assign Date", value: 'not implemented yet'),
                  const SizedBox(height: 5),
                  _InfoText(text: 'Full Address', value: '${customer['fullAddress']}'),
                  const SizedBox(height: 5),
                  _InfoText(text: 'Contact', value: '${customer['contactNumber']}'),
                  // -----------------------------------------------------
                ],
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

class _Heading extends StatelessWidget {
  final String text;
  const _Heading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
  }
}

class _InfoText extends StatelessWidget {
  final String text;
  final dynamic value;
  const _InfoText({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(color: Color(0xFF7D8888))),
          Text('$value', style: const TextStyle(color: Color(0xFF7D8888))),
        ],
      ),
    );
  }
}
