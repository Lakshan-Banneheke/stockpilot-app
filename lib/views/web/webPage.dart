import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stockpilot_app/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          WebView(
            initialUrl: 'https://stockpilot.netlify.app/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller.complete(controller);
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Loader()
              : Stack()
        ],
      ),
    );
  }
}
