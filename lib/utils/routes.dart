import 'package:codeal/core/service_locator.dart';
import 'package:codeal/core/token_info.dart';
import 'package:codeal/modules/company/add_company.dart';
import 'package:codeal/modules/sales-order/manage_sales_order.dart';
import 'package:codeal/modules/user/auth/pages/login_page.dart';
import 'package:codeal/modules/user/home/pages/admin_dashboard.dart';
import 'package:codeal/modules/user/home/pages/coseller_dashboard.dart';
import 'package:codeal/modules/user/home/pages/landing_page.dart';
import 'package:codeal/modules/user/home/pages/super_admin_dashboard.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AutoLoginScreen());

      case '/landing-page':
        return MaterialPageRoute(builder: (_) => const LandingPage());

      case '/users/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) {
          var userRole = sl<TokenInfo>().claims!.role[0];
          if (userRole == "Super_Admin") return const SuperAdminDashboard();
          if (userRole == "Admin") return const AdminDashboard();
          if (userRole == "Co_Seller") return const CoSellerDashboard();

          return Container();
        });

      case '/companies/add':
        return MaterialPageRoute(builder: (_) => AddCompany());

      case '/sales-orders/manage':
        return MaterialPageRoute(builder: (_) => ManageSalesOrder());

      default:
        throw const FormatException("Route not ofund");
    }
  }
}
