import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:flutter/material.dart';

import '../../auth/widgets/confirm_exit.dart';
import '../widgets/dashboard_widgets.dart';

class SuperAdminDashboard extends AppLayout {
  const SuperAdminDashboard({super.key});

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
      child: Container(),
    );
  }
}
