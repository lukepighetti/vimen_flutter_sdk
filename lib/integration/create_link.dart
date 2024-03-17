import 'dart:convert';
import 'dart:io';

import '../models/vimen_link_response.dart';

Future<VimenLinkResponse> createLinkDetails({
  required String path,
  required String clientKey,
  required Map<String, dynamic /* String | bool | num */ > data,
}) async {
  final v = data.values.every((x) => x is String || x is num || x is bool);
  if (!v) throw ArgumentError('param values must be String, bool, or num');

  final client = HttpClient();
  final url = Uri.parse("https://linkmgmtpublic-hymljkcmva-ey.a.run.app");

  final req = await client.postUrl(url);
  req.headers.add('Content-Type', 'application/json');
  req.headers.add('Authorization', 'clientKey $clientKey');
  req.write(jsonEncode({
    "path": path,
    "jsonPayload": data,
  }));

  final res = await req.close();
  assert(res.statusCode == 200);
  final body = await res.transform(utf8.decoder).join();
  final json = jsonDecode(body);
  return VimenLinkResponse.fromJson(json);
}
