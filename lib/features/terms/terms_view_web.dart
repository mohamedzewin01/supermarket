import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/iframe_view.dart';
import 'package:flutter/material.dart';

import '../../core/resources/assets_manager.dart';

class TermsViewWeb extends StatefulWidget {
  const TermsViewWeb({super.key});

  @override
  State<TermsViewWeb> createState() => _TermsViewWebState();
}

class _TermsViewWebState extends State<TermsViewWeb> {

  final String termsUrl = "https://nextlaunch.artawiya.com/terms.html";

  final String viewId = 'iframeElement';

  @override
  void initState() {
    super.initState();

    /// TODO: iframe_view   when web app
    // IframeView.registerViewFactory(viewId, termsUrl);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // height: 30,
                // width: 30,
                padding: EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                    color:ColorManager.white
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 7),
              child: Center(
                child: Image.asset(Assets.logo3, ),
              ),
            ),
          ],
          title: Text(
            'الشروط والأحكام',
            style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16),
          ),
          backgroundColor: ColorManager.primaryColor,
        ),

        body: HtmlElementView(viewType: viewId)

    );
  }
}