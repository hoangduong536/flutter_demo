
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/app_color.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;


  final List<SingleChildCloneableWidget> di;
  final List<Widget> actions;

  PageContainer({this.title, this.di, this.actions, this.child});

  @override
  Widget build(BuildContext context) {
    print("PageContainer - StatelessWidget - build ================");
    return MultiProvider(
      providers: [
        ...di,

      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: AppColor.blue),
          ),
          actions: actions,
        ),
        body: child,
      ),
    );
  }
}

