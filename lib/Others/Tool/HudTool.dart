// import 'package:flutter_general_toast/flutter_general_toast.dart';
// import 'FlutterGeneralToast.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

typedef DissmissBlock = void Function ();

class HudTool {

  // static initBotToast() {
  //   MaterialApp(
  //     title: 'BotToast Demo',
  //     builder: BotToastInit(), //1. call BotToastInit
  //     navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
  //     home: XxxxPage(),
  // )
  // }

  static void showInfoWithStatus(String status) {
    // MyToast.showMessage(status);
    // FlutterGeneralToast.showMessage(status);
    BotToast.showText(text: status);
  }

  static void show() {
    // MyToast.show();
    // FlutterGeneralToast.show();
    BotToast.showLoading();
  }

  static void dismiss({DissmissBlock block}) {
    // MyToast.dismiss();
    // FlutterGeneralToast.dismiss();
    BotToast.closeAllLoading();
  }
}
