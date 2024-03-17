import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension CopyTextExtension on BuildContext {
  Future<void> copyUri(Uri uri) async {
    final url = uri.toString();
    final fn = ScaffoldMessenger.of(this).showSnackBar;
    await Clipboard.setData(ClipboardData(text: url));
    fn(SnackBar(content: Text("Copied $url to clipboard")));
  }
}
