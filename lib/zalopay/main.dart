import 'package:flutter/material.dart';
import 'package:test_thuetro/zalopay/screens/dashboard.dart';
import 'package:test_thuetro/zalopay/utils/config.dart';
import 'package:test_thuetro/zalopay/utils/theme_data.dart';


// void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: myTheme,
      home: Dashboard(title: AppConfig.appName, version: AppConfig.version,),
      debugShowCheckedModeBanner: false,
    );
  }
}