import 'package:bitsdojo_window/bitsdojo_window.dart'; // Make sure this is imported for appWindow
import 'package:ezo/core/layout/unified_scroll_behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/router/app_router.dart';
import 'firebase_options.dart';

import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Use path URL strategy on web so reset/verify links work without # prefix
  if (kIsWeb) usePathUrlStrategy();
  await ServiceLocator.instance.initialize();

  runApp(const ProviderScope(child: EzoPosApp()));

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = const Size(800, 600);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "AeroPOS";
    appWindow.show();
  });
}

class EzoPosApp extends ConsumerWidget {
  const EzoPosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Ezo POS',
      scrollBehavior: UnifiedScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
      theme: ThemeData(
        fontFamily: 'AppFont',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
