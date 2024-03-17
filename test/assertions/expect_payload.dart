import 'package:flutter_test/flutter_test.dart';
import 'package:vimen_sdk/integration/get_link.dart';

Future<void> expectPayload(String link, Map<String, dynamic> payload) async {
  final res = await getLinkDetails(Uri.parse(link));
  expect(res.data, payload);
}
