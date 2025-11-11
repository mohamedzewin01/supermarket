import 'package:manarat_amjad/core/widgets/custom_web_view_mobile.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWebViewMobile(url: "https://nextlaunch.artawiya.com/about.html");
  }
}
