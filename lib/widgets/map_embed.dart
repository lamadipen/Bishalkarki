import 'package:flutter/widgets.dart';

import 'map_embed_stub.dart' if (dart.library.html) 'map_embed_web.dart'
    as map_impl;

class MapEmbed extends StatelessWidget {
  const MapEmbed({super.key, required this.embedUrl});

  final String embedUrl;

  @override
  Widget build(BuildContext context) {
    return map_impl.MapEmbedImpl(embedUrl: embedUrl);
  }
}
