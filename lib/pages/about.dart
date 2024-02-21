import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:url_launcher/url_launcher_string.dart';

// get version number
Future<String> _getVersionNumber() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

// launch url
Future<void> _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
