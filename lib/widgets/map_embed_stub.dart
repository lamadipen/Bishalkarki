import 'package:flutter/material.dart';

class MapEmbedImpl extends StatelessWidget {
  const MapEmbedImpl({super.key, required this.embedUrl});

  final String embedUrl;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Map is available on web build.'),
    );
  }
}
