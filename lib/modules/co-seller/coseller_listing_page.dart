import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/coseller_details.dart';
import 'package:team_monitor/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CosellerListingPage extends AppLayout {
  const CosellerListingPage({super.key});

  @override
  Widget header() => const AppHeader(title: "Coseller Listing");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => CosellerCubit()..getCosellersForCompany(),
      child: BlocConsumer<CosellerCubit, CosellerState>(
        listener: (context, state) {
          if (state is CosellerError) sl<AppToast>().error(state.errorMsg);
        },
        builder: (context, state) {
          if (state is CosellerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CosellerListLoaded) {
            var cosellers = state.cosellers;
            if (cosellers.isEmpty) return const Center(child: Text('No Co-Seller Found'));

            return ListView(
              children: cosellers.map((coseller) {
                return ListTile(
                  title: Text("${coseller['name']}"),
                  onTap: () {
                    showAppDialogBox(
                      context: context,
                      title: "Co-Seller Information",
                      content: CosellerDetails(cosellerId: coseller['id']),
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
