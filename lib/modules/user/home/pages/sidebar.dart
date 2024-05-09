import 'package:codeal/core/service_locator.dart';
import 'package:codeal/core/token_info.dart';
import 'package:codeal/modules/co-seller/commission_details.dart';
import 'package:codeal/modules/co-seller/coseller_listing_page.dart';
import 'package:codeal/modules/company/company_listing_page.dart';
import 'package:codeal/modules/customer/customer_listing_page.dart';
import 'package:codeal/modules/payment-methods/bank-details/bank_details_listing_page.dart';
import 'package:codeal/modules/payment-methods/digital-wallets/digital_wallets_listing_page.dart';
import 'package:codeal/modules/product-offer/offer_listing_page.dart';
import 'package:codeal/modules/product/product_listing_page.dart';
import 'package:codeal/modules/sales-order/sales_order_listing_page.dart';
import 'package:codeal/modules/unit/unit_listing_page.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_widgets.dart';
import '../widgets/sidebar_widgets.dart';

class MySideBar extends AppLayout {
  const MySideBar({super.key});

  @override
  Widget userInfo() => const UserInfoStack();

  Widget getUserContent() {
    final userRole = sl<TokenInfo>().currentUserRole;
    if (userRole == "Super_Admin") return const _SuperAdminContent();
    if (userRole == "Admin") return const _AdminContent();
    if (userRole == "Co_Seller") return const _CosellerContent();

    return Container();
  }

  @override
  Widget content(BuildContext context) {
    return ListView(
      children: [
        getUserContent(),
        // logout
        SideBarContent(
          icon: Icons.logout,
          title: 'Logout Account',
          onClick: () async {
            await sl<TokenInfo>().clear();
            if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/landing-page', (route) => false);
          },
        ),

        const SizedBox(height: 15),
        const SupportUsSection(),
        const SizedBox(height: 15),
        const OurPromisesSection(),

        // copyright
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'Copy Right © | All Right Reserve | Kafals',
            style: TextStyle(fontSize: 11, color: Color(0xFF2D264B)),
          ),
        ),
      ],
    );
  }
}

class _SuperAdminContent extends StatelessWidget {
  const _SuperAdminContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideBarContent(
          icon: Icons.home,
          title: 'Units',
          subtitle: "Manage Product Units",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UnitListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Companies',
          subtitle: "View Your Companies",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyListingPage())),
        ),
      ],
    );
  }
}

class _AdminContent extends StatelessWidget {
  const _AdminContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideBarContent(
          icon: Icons.home,
          title: 'Co-Sellers',
          subtitle: "View Your Co-Seller Agents",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CosellerListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Products',
          subtitle: "Manage Your Products",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Offers',
          subtitle: "Manage Your Offers",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OfferListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Sales Orders',
          subtitle: "Manage Your Orders",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesOrderListingPage())),
        ),
      ],
    );
  }
}

class _CosellerContent extends StatelessWidget {
  const _CosellerContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideBarContent(
          icon: Icons.home,
          title: 'Customers',
          subtitle: "Manage Your Customers",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Sales Orders',
          subtitle: "Manage Your Orders",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesOrderListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Bank Details',
          subtitle: "Manage Your Bank Details",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BankDetailsListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'Digital Wallets',
          subtitle: "Manage Your Digital Wallets",
          onClick: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DigitalWalletsListingPage())),
        ),
        SideBarContent(
          icon: Icons.home,
          title: 'My Commission',
          subtitle: "Your Commission Details",
          onClick: () => showAppDialogBox(
            context: context,
            title: "Commission Details",
            content: const CosellerCommissionDetails(),
          ),
        ),
      ],
    );
  }
}
