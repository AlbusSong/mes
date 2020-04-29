import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Model/Trifle.dart';
import 'Home/HomePage.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/NativeCommunicationTool.dart';
import 'Others/Const/Const.dart';
import 'package:mes/Others/Network/FlutterCache.dart';

void main() {
  runApp(MESApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});

  _initSomeThings();
}

void _initSomeThings() {
  MeInfo();
  FlutterCache();
  NativeCommunicationTool();
  Trifle();
}

class MESApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MES App',
      theme: ThemeData(
        primaryColor: hexColor(MAIN_COLOR),
      ),
      home: HomePage(),
    );
  }
}

// flutter packages pub run build_runner watch
// CAB1911250019FFF
// CAB1911250498FFF
