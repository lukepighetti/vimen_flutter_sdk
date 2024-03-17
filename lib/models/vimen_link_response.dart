import 'package:flutter/foundation.dart';

class VimenLinkResponse {
  @protected
  VimenLinkResponse({
    required this.projectSlug,
    required this.shortLink,
    required this.createdAt,
    required this.data,
  });

  static VimenLinkResponse fromJson(Map<String, dynamic> json) =>
      VimenLinkResponse(
        projectSlug: json['projectSlug'] as String,
        shortLink: json['shortLink'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['creationDate']),
        data: json['jsonPayload'] as Map<String, dynamic>,
      );

  final String projectSlug;

  final String shortLink;

  final DateTime createdAt;

  final Map<String, dynamic> data;

  late final Uri uri = Uri.parse("https://$projectSlug.vimen.io/$shortLink");

  @override
  String toString() => "VimenLinkResponse("
      "uri: $uri,"
      "payload: $data"
      ")";

  // final String id;

  // final String appId;

  // final String orgId;

  // final DateTime editedAt;

  // final String path;

  // final String displayName;

  // final String webPath;
}
