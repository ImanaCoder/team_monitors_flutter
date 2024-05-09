import 'package:codeal/core/service_locator.dart';
import 'package:codeal/core/token_info.dart';
import 'package:codeal/modules/co-seller/coseller_update_page.dart';
import 'package:codeal/modules/company/update_company.dart';
import 'package:codeal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInfoStack extends StatelessWidget {
  const UserInfoStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 120),
        Container(
          height: 80,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF652D90),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
        ),
        Positioned(
          top: 10,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          child: const _StackContent(),
        ),
      ],
    );
  }
}

class _StackContent extends StatelessWidget {
  const _StackContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Today's date
        Text(
          DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        // profile pic and notification
        Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [sl<AppConstants>().boxShadow],
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (sl<TokenInfo>().currentUserRole == "Admin") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateCompany()));
                  } else if (sl<TokenInfo>().currentUserRole == "Co_Seller") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CosellerUpdatePage()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${sl<TokenInfo>().currentUserRole}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xFF2D3B8A),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Id - ${sl<TokenInfo>().claims?.userDetailsId}',
                              style: const TextStyle(color: Color(0xFF7D8888)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DashboardContainer extends StatelessWidget {
  final String title;
  final Widget? titleSuffix;
  final Widget child;
  const DashboardContainer({super.key, required this.title, required this.child, this.titleSuffix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [sl<AppConstants>().boxShadow],
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Title container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                color: Color(0xFFD9D9D9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Color(0xFF2D3B8A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  titleSuffix ?? Container(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class CountBox extends StatelessWidget {
  final num value;
  final String text;
  const CountBox({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF049C2F),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7D8888),
          ),
        ),
      ],
    );
  }
}
