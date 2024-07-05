import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:team_monitor/modules/payment-methods/bank-details/manage_bank_details_page.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankDetailsListingPage extends AppLayout {
  const BankDetailsListingPage({super.key});

  @override
  bool get applyPaddingToContent => false;

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => CosellerCubit()..getAllBankDetailsForCoseller(),
      child: Column(
        children: [
          // Header
          AppHeader(
            title: "Bank Details",
            actions: [
              BlocBuilder<CosellerCubit, CosellerState>(
                builder: (context, state) {
                  return AddNewHeaderAction(onTap: () async {
                    var res = await showAppDialogBox(
                      context: context,
                      title: "New Bank Details",
                      content: ManageBankDetailsPage(),
                    );
                    if (res != null && res == true && context.mounted) {
                      context.read<CosellerCubit>().getAllBankDetailsForCoseller();
                    }
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: sl<AppConstants>().appPadding,
              child: BlocConsumer<CosellerCubit, CosellerState>(
                listener: (context, state) {
                  if (state is CosellerError) sl<AppToast>().error(state.errorMsg);
                },
                builder: (context, state) {
                  if (state is CosellerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BankDetailsListLoaded) {
                    var bankDetails = state.bankDetails;
                    if (bankDetails.isEmpty) return const Center(child: Text('No Bank Details Found'));

                    return ListView(
                      children: bankDetails.map((item) {
                        return ListTile(
                          title: Text("${item['bankName']}"),
                          subtitle: Text("${item['accountNumber']}"),
                        );
                      }).toList(),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
