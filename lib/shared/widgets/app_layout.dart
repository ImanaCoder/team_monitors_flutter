import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/core/token_info.dart';
import 'package:team_monitor/modules/product/manage_product_page.dart';
import 'package:team_monitor/modules/user/home/pages/sidebar.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  bool get applyPaddingToContent => true;

  Widget header() => Container();

  Widget userInfo() => Container();

  Widget floatingActionButton() => Container();

  Widget content(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            header(),
            userInfo(),
            Expanded(
              child: applyPaddingToContent
                  ? Padding(padding: sl<AppConstants>().appPadding, child: content(context))
                  : content(context),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(width: double.infinity, height: 70),
        // background color
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          height: 35,
          child: Container(
            color: const Color(0xFFECF2FF),
            // color: Colors.green,
          ),
        ),
        // dashboard
        Positioned(
          left: MediaQuery.of(context).size.width / 5 - 11,
          bottom: 5,
          child: InkWell(
            child: const Icon(Icons.home, size: 22, color: Color(0xFF7D8888)),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false),
          ),
        ),
        // add icon
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 30,
          bottom: 20,
          child: InkWell(
            onTap: () {
              if (sl<TokenInfo>().currentUserRole == "Co_Seller") {
                Navigator.pushNamed(context, '/sales-orders/manage');
              } else if (sl<TokenInfo>().currentUserRole == "Super_Admin") {
                Navigator.pushNamed(context, '/companies/add');
              } else if (sl<TokenInfo>().currentUserRole == "Admin") {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ManageProductPage()));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF903B96),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 25),
              ),
            ),
          ),
        ),
        // settings
        Positioned(
          right: MediaQuery.of(context).size.width / 5 + 11,
          bottom: 5,
          child: InkWell(
            child: const Icon(Icons.settings, size: 22, color: Color(0xFF7D8888)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MySideBar()));
            },
          ),
        ),
      ],
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final String svgName;
  final String routeName;
  const NavBarItem({super.key, required this.title, required this.svgName, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (routeName == '/dashboard') {
        //   Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
        // } else if (title == 'Manage') {
        //   // Scaffold.of(context).openEndDrawer();
        //   // Navigator.push(context, MaterialPageRoute(builder: (_) => const AppDrawer()));
        //   Navigator.push(context, MaterialPageRoute(builder: (_) => const MySideBar()));
        // } else {
        //   if (!User.isLoggedIn) {
        //     Navigator.pushNamed(context, '/landing');
        //   } else if (User.currentUser.isFree()) {
        //     Navigator.pushNamed(context, '/premium/features');
        //   } else {
        //     Navigator.pushNamed(context, routeName);
        //   }
        // }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/svg/bottom/$svgName', width: 25),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2D264B),
            ),
          )
        ],
      ),
    );
  }
}

Future<bool?> showAppDialogBox({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    content,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
