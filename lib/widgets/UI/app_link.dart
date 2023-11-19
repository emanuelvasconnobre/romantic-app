import 'package:flutter/material.dart';
import 'package:romanticapp/utils/app_color.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppLink extends StatelessWidget {
  final String text;
  final String? routeName;
  final String? externalUrl;
  final TextStyle? style;

  const AppLink(this.text, {this.routeName, this.externalUrl, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName!);
        } else if (externalUrl != null) {
          _launchURL(externalUrl!);
        }
      },
      child: Text(
        text,
        style: style ?? const TextStyle(
              color: AppColor.primaryBgColor,
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}
