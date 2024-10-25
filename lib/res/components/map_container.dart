import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
