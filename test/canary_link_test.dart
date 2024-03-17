import 'package:flutter_test/flutter_test.dart';
import 'package:vimen_sdk/integration/create_link.dart';

import 'assertions/expect_payload.dart';
import 'assertions/expect_redirect.dart';

main() {
  group('canary links', () {
    test('redirect', () async {
      await expectRedirect(
        'https://glp.vimen.io/ios',
        'https://apps.apple.com/us/app/grocery-list-pro/id1553681782',
      );
      await expectRedirect(
        'https://glp.vimen.io/android',
        'https://play.google.com/store/apps/details?id=com.lukepighetti.vgl',
      );
      await expectRedirect(
        'https://glp.vimen.io/terms',
        'https://grocerylistpro.com/terms',
      );
      await expectRedirect(
        'https://glp.vimen.io/download',
        'https://grocerylistpro.com/',
      );
      await expectRedirect(
        'https://glp.vimen.io/invite/foo',
        'https://grocerylistpro.com/invite/foo',
      );
    });

    test('payload', () async {
      await expectPayload('https://glp.vimen.io/invite/foo', {
        'inviteId': 'foo',
      });

      await expectPayload('https://glp.vimen.io/download', {});
    });

    test('createLink', () async {
      final x = await createLinkDetails(
        clientKey: 'abc123',
        path: '/test${DateTime.now().millisecondsSinceEpoch}',
        data: {"test": "foo"},
      );

      expect(x.data, {"test": "foo"});
    });
  });
}
