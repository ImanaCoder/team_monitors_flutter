import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:team_monitor/modules/payment-methods/digital-wallets/manage_digital_wallets_page.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DigitalWalletsListingPage extends AppLayout {
  const DigitalWalletsListingPage({super.key});

  @override
  bool get applyPaddingToContent => false;

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => CosellerCubit()..getAllDigitalWalletsForCoseller(),
      child: Column(
        children: [
          // Header
          AppHeader(
            title: "Digital Wallets",
            actions: [
              BlocBuilder<CosellerCubit, CosellerState>(
                builder: (context, state) {
                  return AddNewHeaderAction(onTap: () async {
                    var res = await showAppDialogBox(
                      context: context,
                      title: "New Digital Wallet",
                      content: ManageDigitalWalletsPage(),
                    );
                    if (res != null && res == true && context.mounted) {
                      context.read<CosellerCubit>().getAllDigitalWalletsForCoseller();
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
                  } else if (state is DigitalWalletListLoaded) {
                    var digitalWallets = state.digitalWallets;
                    if (digitalWallets.isEmpty) return const Center(child: Text('No Digital Wallets Found'));

                    return ListView(
                      children: digitalWallets.map((item) {
                        return ListTile(
                          title: Text("${item['walletName']}"),
                          subtitle: Text("${item['walletId']}"),
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
