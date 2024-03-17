import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Future<void> expectRedirect(String from, String to) async {
  final client = HttpClient();
  final req = await client.getUrl(Uri.parse(from));
  req.followRedirects = false;
  final res = await req.close();

  final destination = res.headers.value(HttpHeaders.locationHeader);

  expect(res.statusCode, 302);
  expect(res.isRedirect, true);
  expect(destination, to);
}
