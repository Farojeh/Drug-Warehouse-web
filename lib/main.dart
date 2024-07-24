import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/desktoplog.dart';
import 'package:flutter_web/desktop/home.dart';
import 'package:flutter_web/mobile/mobilelog.dart';
import 'package:flutter_web/tablet/tabletlog.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/provider.dart';

void main() {
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 1000, tablet: 510, watch: 500),
  );
  runApp(ChangeNotifierProvider(
    create: (ctx) => Mypro(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => Mobilelogin(),
        tablet: (BuildContext context) => Tabletlogin(),
        desktop: (BuildContext context) => Desktoplogin(),
      ),
      routes: {
        Homepage.homename:(context) => ScreenTypeLayout.builder(
        mobile: (BuildContext context) =>Mobilelogin(),
        tablet: (BuildContext context) => Tabletlogin(),
        desktop: (BuildContext context) => Homepage(0),
      ),
      
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw Scaffold(
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
