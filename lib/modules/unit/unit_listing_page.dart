import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/unit/cubit/unit_cubit.dart';
import 'package:team_monitor/modules/unit/manage_unit_page.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitListingPage extends AppLayout {
  const UnitListingPage({super.key});

  @override
  bool get applyPaddingToContent => false;

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitCubit()..getAllUnits(),
      child: Column(
        children: [
          // Header
          AppHeader(
            title: "Product Units",
            actions: [
              BlocBuilder<UnitCubit, UnitState>(
                builder: (context, state) {
                  return AddNewHeaderAction(onTap: () async {
                    var res = await showAppDialogBox(context: context, title: "New Unit", content: ManageUnitPage());
                    if (res != null && res == true && context.mounted) {
                      context.read<UnitCubit>().getAllUnits();
                    }
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: sl<AppConstants>().appPadding,
              child: BlocConsumer<UnitCubit, UnitState>(
                listener: (context, state) {
                  if (state is UnitError) sl<AppToast>().error(state.errorMsg);
                },
                builder: (context, state) {
                  if (state is UnitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UnitListLoaded) {
                    var units = state.units;
                    if (units.isEmpty) return const Center(child: Text('No Units Found'));

                    return ListView(
                      children: units.map((unit) {
                        return ListTile(
                          title: Text(unit['name']),
                          subtitle: Text(unit['status'].toString()),
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
