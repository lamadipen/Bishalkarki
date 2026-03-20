import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class MapEmbedImpl extends StatelessWidget {
  const MapEmbedImpl({super.key, required this.embedUrl});

  final String embedUrl;

  @override
  Widget build(BuildContext context) {
    final viewType = 'google-map-${embedUrl.hashCode}';
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..src = embedUrl
        ..allowFullscreen = true
        ..referrerPolicy = 'no-referrer-when-downgrade';
      iframe.style.border = '0';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      return iframe;
    });

    return HtmlElementView(viewType: viewType);
  }
}
