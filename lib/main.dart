import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:water_drinking_reminder/localization/AppLocalizations.dart';
import 'package:water_drinking_reminder/screen/SplashScreen.dart';
import 'package:water_drinking_reminder/screen/auth/OnBoardingScreen.dart';

import 'package:water_drinking_reminder/style/AppTheme.dart';
import 'package:water_drinking_reminder/utils/Constants.dart';

//ye real ha
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Worth Of Water',
        theme: AppTheme.lightTheme, // define your theme
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
        routes: <String, WidgetBuilder>{},
        navigatorKey: navigatorKey,
        localizationsDelegates: [
          const MyLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ''),
        ]);
  }
}
