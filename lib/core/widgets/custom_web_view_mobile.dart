import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../resources/assets_manager.dart';

class CustomWebViewMobile extends StatefulWidget {
  const CustomWebViewMobile({super.key, required this.url});
  final String url;

  @override
  State<CustomWebViewMobile> createState() => _CustomWebViewMobileState();
}

class _CustomWebViewMobileState extends State<CustomWebViewMobile> {
  late final WebViewController _controller;

  String addTimestampToUrl(String url) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    if (url.contains('?')) {
      return "$url&v=$timestamp";
    } else {
      return "$url?v=$timestamp";
    }
  }

  @override
  void initState() {
    super.initState();
    final urlWithTimestamp = addTimestampToUrl(widget.url);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(urlWithTimestamp));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: ColorManager.primaryColor,
              child: WebViewWidget(controller: _controller)),
          Positioned(
            top: 15,
            right: 15,
           child:SafeArea(
             child: InkWell(
               onTap: () {
                 Navigator.pop(context);
               },
               child: Container(
                 height: 40,
                 width: 40,
                 padding: EdgeInsets.only(right: 7),
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
           )
          ),
          Positioned(
              top: 15,
              left: 15,
           child:SafeArea(
             child: Container(
               height: 40,
               width: 40,
               padding: EdgeInsets.only(right: 7),
               // decoration: BoxDecoration(
               //   shape: BoxShape.circle,
               //   border: Border.all(color: Colors.grey.shade200),
               //   // color: ColorManager.primaryColor,
               // ),
               child: Center(
                 child: Image.asset(Assets.logo3, ),
               ),
             ),
           )
          ),
        ],
      ),
    );

  }
}