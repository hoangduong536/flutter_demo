
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/app_color.dart';
import 'package:flutter_app/shared/identifier.dart';
import 'package:flutter_app/splash/splash.dart';

import 'module/sign_in/sign_in_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: AppColor.yellow,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        Identifier.SIGN_IN_PAGE: (context) => SignInPage(),

      },
    );
  }
}


