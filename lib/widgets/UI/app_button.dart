import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppButton extends StatelessWidget {
  final String text;
  final String? routeName;
  final String? externalUrl;
  final ButtonStyle? style;
  final void Function()? onPressed;

  const AppButton(this.text,
      {this.routeName,
      this.externalUrl,
      this.style,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => _redirect(context),
      style: style ??
          const ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
          ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
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

  _redirect(BuildContext context) {
    if (routeName != null) {
      Navigator.pushNamed(context, routeName!);
    } else if (externalUrl != null) {
      _launchURL(externalUrl!);
    }
  }
}
