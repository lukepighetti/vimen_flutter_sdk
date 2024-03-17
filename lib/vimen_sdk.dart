library vimen_sdk;

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:vimen_sdk/integration/create_link.dart';
import 'package:vimen_sdk/models/vimen_link_response.dart';

import 'integration/get_link.dart';
import 'models/vimen_link.dart';

export 'models/vimen_link.dart';
export 'models/vimen_link_response.dart';

class Vimen {
  static var clientKey = '';

  // singleton constructor, singleton instance field, protected constructor
  Vimen._();
  static final instance = Vimen._();
  factory Vimen() => instance;

  // services
  final _appLinks = AppLinks();

  Future<VimenLink?> getInitialLink() =>
      _appLinks.getInitialAppLink().then((uri) {
        if (uri == null) return null;
        return _handleUri(true, uri);
      });

  Stream<VimenLink> linkStream() async* {
    await for (final uri in _appLinks.uriLinkStream) {
      yield await _handleUri(false, uri);
    }
  }

  Stream<VimenLink> allLinkStream() async* {
    final initial = await getInitialLink();
    if (initial != null) yield initial;
    yield* linkStream();
  }

  Future<VimenLink> _handleUri(bool launching, Uri uri) async {
    final details = await getLinkDetails(uri);
    return VimenLink(launching, uri, details.path, details.data);
  }

  Future<VimenLinkResponse> createLink({
    required String path,
    Map<String, dynamic> data = const {},
  }) async {
    _requiresConfig();
    return createLinkDetails(
      path: path,
      clientKey: clientKey,
      data: data,
    );
  }

  void _requiresConfig() {
    assert(clientKey.isNotEmpty, 'set Vimen.clientKey before use');
  }
}
