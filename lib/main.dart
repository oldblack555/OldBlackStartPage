import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/controller/music_controller.dart';
import 'package:terminal/controller/user_controller.dart';
import 'package:terminal/handle/global_catch_error.dart';
import 'package:terminal/provider/others/system_provider.dart';
import 'package:terminal/provider/others/user_provider.dart';
import 'package:terminal/ui/terminal/terminal_ui.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  SystemProvider.load().then(
    (value) {
      GlobalCatchError().run(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ContentController()),
            ChangeNotifierProvider(create: (_) => UserController()),
            ChangeNotifierProvider(create: (_) => MusicController()),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => UserProvider.load(),
    );
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: '老黑起始页',
      theme: ThemeData(
          // fontFamily: "msyh",
          ),
      home: const Scaffold(
        body: TerminalUI(),
      ),
    );
  }
}
