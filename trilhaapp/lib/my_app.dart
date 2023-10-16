import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/splash_screen/splash_screen.dart';

//import 'pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreenPage(),
    );
  }
}
