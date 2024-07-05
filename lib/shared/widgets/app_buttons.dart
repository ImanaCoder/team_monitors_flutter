import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const AppButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: sl<AppConstants>().appColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class AddNewHeaderAction extends StatelessWidget {
  final void Function()? onTap;
  const AddNewHeaderAction({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(200, 200, 255, 1),
        ),
        child: const Row(
          children: [
            Icon(Icons.add, color: Colors.black),
            SizedBox(width: 4),
            Text('Add New', style: TextStyle(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
