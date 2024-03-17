import 'package:flutter/foundation.dart';

class VimenLink {
  @protected
  VimenLink(
    this.launching,
    this.uri,
    this.path,
    this.data,
  ) : resolvedAt = DateTime.now();

  final bool launching;

  final Uri uri;

  late final String url = uri.toString();

  final DateTime resolvedAt;

  final String path;

  final Map<String, dynamic> data;

  @override
  String toString() => "VimenLink("
      "launching: $launching, "
      "link: $uri, "
      "resolvedAt: $resolvedAt"
      ")";
}
