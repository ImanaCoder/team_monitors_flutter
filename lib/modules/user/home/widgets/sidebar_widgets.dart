import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

/// contains row with icon as first child, title as second child
class SideBarContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Function()? onClick;
  const SideBarContent({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: [
            // SvgPicture.asset('assets/svg/sidebar/$svgName', width: 20),
            Icon(icon, size: 20),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFF652D90),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String text;
  const ContentText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFF0000),
      ),
    );
  }
}

/// contains column with icon as first child, title as second child
class SideBarButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onClick;
  const SideBarButton({super.key, required this.title, required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD9D9D9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Color(0xFF2D264B)),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportUsSection extends StatelessWidget {
  const SupportUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Support Us!',
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFF652D90),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SideBarButton(
              title: 'Rate Us',
              icon: Icons.rate_review,
              onClick: () async {
                launchUrl(
                  Uri.parse('https://play.google.com/store/apps/details?id=com.kafals.codeal'),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            SideBarButton(
              title: 'Review Us',
              icon: Icons.rate_review,
              onClick: () async {
                launchUrl(
                  Uri.parse('https://play.google.com/store/apps/details?id=com.kafals.codeal'),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            // SideBarButton(
            //   title: 'Share Us',
            //   svgName: 'shareicon.svg',
            //   onClick: () async {
            //     await Share.share(
            //       'Download DSZenith For Ultimate Direct Selling Experience https://play.google.com/store/apps/details?id=com.kafals.dszenith',
            //       subject: 'Be A Professional Direct Seller',
            //     );
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}

class OurPromisesSection extends StatelessWidget {
  const OurPromisesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Our Promises',
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFF652D90),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svg/sidebar/safe.svg', width: 20),
                const Text('100% Safe & Secure', style: TextStyle(fontSize: 11)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                SvgPicture.asset('assets/svg/sidebar/automaticbackup.svg', width: 20),
                const Text('Automatic Backup', style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
