import 'dart:convert';

import 'package:flutter/foundation.dart';

class VimenServerLink {
  @protected
  VimenServerLink({
    required this.path,
    required this.projectSlug,
    required this.webPath,
    required this.data,
  });

  static VimenServerLink fromJson(String json) {
    final map = jsonDecode(json) as Map;
    return VimenServerLink(
      path: map['path'] as String,
      projectSlug: map['projectSlug'] as String,
      webPath: map['webPath'] as String,
      data: map['jsonPayload'] as Map<String, dynamic>? ?? {},
    );
  }

  final String path;
  final String projectSlug;
  final String webPath;
  final Map<String, dynamic> data;

  @override
  String toString() => "VimenServerLink("
      "path: $path,"
      "data: $data"
      ")";
}
