import 'package:flutter/material.dart';
import 'package:buruh_apps/view/splashscreen_view.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'SplashScreen',
//     home: SplashScreenPage(),
//   ));
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'SplashScreen',
            theme: ThemeData(primarySwatch: Colors.red),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: SplashScreenPage(),
          );
        });
  }
}

