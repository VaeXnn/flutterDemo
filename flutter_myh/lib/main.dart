import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tabbar/root_view_page.dart';
import './base/config.dart';
import 'route/route.dart';
import './base/app_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppManager>(create: (_) => AppManager.instance),
      ],
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: context.watch<AppManager>().themeData,
          home: RootPage(),
          routes: AppRoute.getPageRoutes(context),
        );
      },
    );
  }
}
