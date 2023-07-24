import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class webview extends StatelessWidget {
  final String? url;
  // late final WebViewController controller;
  webview(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller:WebViewController() ..loadRequest(Uri.parse(url!)),
      ),
    );
  }
}
