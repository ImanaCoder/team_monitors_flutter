import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CosellerDetails extends StatelessWidget {
  final int cosellerId;
  const CosellerDetails({super.key, required this.cosellerId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocProvider(
        create: (context) => CosellerCubit()..getCosellerDetails(cosellerId),
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
              var coseller = state.coseller;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${coseller['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  Text('Co-Seller ID ${coseller['id']}', style: const TextStyle(color: Color(0xFF7D8888))),
                  const SizedBox(height: 5),
                  // -----------------------------------------------------
                  const _Heading(text: 'Personal Information'),
                  const _InfoText(text: "Assign Date", value: 'not implemented yet'), // TODO
                  const SizedBox(height: 5),
                  _InfoText(text: 'Full Address', value: '${coseller['fullAddress']}'),
                  const SizedBox(height: 5),
                  _InfoText(text: 'Contact', value: '${coseller['contact']}'),
                  // -----------------------------------------------------
                  const _Heading(text: 'Business Information'),
                  _InfoText(text: 'Total Sales', value: '${coseller['totalSales']}'),
                  _InfoText(text: 'Total Customers', value: '${coseller['totalCustomers']}'),
                  _InfoText(text: 'Total Commission', value: '${coseller['totalCommission']}'),
                  _InfoText(text: 'Commission Paid', value: '${coseller['totalCommissionPaid']}'),
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
