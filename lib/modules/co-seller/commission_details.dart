import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/cubit/coseller_cubit.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CosellerCommissionDetails extends StatelessWidget {
  const CosellerCommissionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CosellerCubit()..getCommissionInfo(),
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
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Received: ${info['commissionReceived']}'),
                  Text('To Be Received: ${info['commissionToBeReceived']}'),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
