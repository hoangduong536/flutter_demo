
import 'package:flutter/material.dart';
import 'package:flutter_app/data/spref/spref.dart';
import 'package:flutter_app/shared/constant.dart';
import 'package:flutter_app/shared/identifier.dart';
import 'package:flutter_app/shared/image_asset.dart';
import 'package:flutter_app/shared/style/txt_style.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startApp();
  }

  _startApp() {
    Future.delayed(
        Duration(seconds: 3),
        () {

          Navigator.pushReplacementNamed(context, Identifier.SIGN_IN_PAGE);
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Image.asset(
              ImageAsset.logo_duong,
              height: 150,
              width: 150,
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'My name:Nguyễn Hoàng Dương\n\nEmail:hoangduong536@gmai.com\n\nPhone:0937.972.678',
                style: TxtStyle.normal_font_size_19(),
              ),

            )

          ],
        ),
      ),

    );
  }
}

