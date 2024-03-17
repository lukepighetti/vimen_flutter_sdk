import 'package:example/ui/bundle_id_text.dart';
import 'package:example/ui/copy_uri_extension.dart';
import 'package:flutter/material.dart';
import 'package:vimen_sdk/vimen_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Vimen.clientKey = 'abc123';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final vimen = Vimen.instance;
  final links = <Object /* VimenLink | VimenLinkResponse */ >[];

  @override
  void initState() {
    vimen.allLinkStream().listen((link) {
      debugPrint('[link]: $link');
      setState(() => links.add(link));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vimen.io',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("vimen.io"),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  const BundleIdText(),
                  for (final link in links)
                    if (link is VimenLink)
                      ListTile(
                        leading: const Icon(Icons.arrow_forward_outlined),
                        title: Text(link.uri.toString()),
                        trailing: link.launching
                            ? const Icon(Icons.rocket_launch)
                            : null,
                        subtitle: Text("data: ${link.data}"),
                      )
                    else if (link is VimenLinkResponse)
                      ListTile(
                        leading: const Icon(Icons.arrow_back_outlined),
                        title: Text(link.uri.toString()),
                        subtitle: Text("data: ${link.data}"),
                        onTap: () => context.copyUri(link.uri),
                      )
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final linkResponse = await vimen.createLink(
              path: '/fake/${DateTime.now().millisecondsSinceEpoch}',
              data: {"test": "foo"},
            );
            setState(() => links.add(linkResponse));
          },
        ),
      ),
    );
  }
}
