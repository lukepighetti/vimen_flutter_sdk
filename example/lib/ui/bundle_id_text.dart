import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BundleIdText extends StatelessWidget {
  const BundleIdText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final x = snapshot.data;

        if (x == null) {
          return const SizedBox();
        } else {
          return Text(x.packageName);
        }
      },
    );
  }
}
