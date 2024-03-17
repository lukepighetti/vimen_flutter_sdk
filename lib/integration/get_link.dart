import 'dart:convert';
import 'dart:io';

import '../models/vimen_server_link.dart';

Future<VimenServerLink> getLinkDetails(Uri uri) async {
  final x = uri.replace(queryParameters: {
    ...uri.queryParametersAll,
    "resolve": "true",
  });

  final client = HttpClient();
  final req = await client.getUrl(x);
  final res = await req.close();
  assert(res.statusCode == 200);
  final body = await res.transform(utf8.decoder).join();
  return VimenServerLink.fromJson(body);
}
