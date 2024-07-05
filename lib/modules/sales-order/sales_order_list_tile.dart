import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';

import 'sales_order_details.dart';

class SalesOrderListTile extends StatelessWidget {
  final dynamic order;
  const SalesOrderListTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () {
          if (order['type'] == "Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SalesOrderDetails(orderId: order['id'], orderType: order['type']),
              ),
            );
          } else {
            sl<AppToast>().error("TODO: Offer type order not implemented yet");
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("#${order['id']}", style: const TextStyle(color: Colors.red, fontSize: 18)),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: Text(
                      order['customerType'] == 0 ? 'Individual' : 'Business',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Text(
                "${order['customerName']}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text("${order['coSellerName']}", style: const TextStyle(color: Color(0xFF7D8888), fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
