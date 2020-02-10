import 'package:flutter/material.dart';
import 'package:flutter_general_toast/flutter_general_toast.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'HomeMenu.dart';

import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Login/LoginPage.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // HomePage({Key key, this.title}) : super(key: key);
  bool _isLoginInfoRefreshed = false;

  void _getDataFromServer() {
    if (_isLoginInfoRefreshed == true) {
      return;
    }
    _isLoginInfoRefreshed = true;
    HttpDigger.login(MeInfo().username, MeInfo().password,
        success: ((int code, String message, dynamic responseJson) {
      print("Login: $responseJson");

      hideKeyboard(_scaffoldKey.currentContext);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // MyToast.APP_CONTEXT = context;
    FlutterGeneralToast.APP_CONTEXT = context;
    Scaffold scf = Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f0eff5"),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("智无形云MES"),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Image.asset("Others/Images/Home-CompanyLogo.jpeg",
            width: 300, height: 300),
      ),
      drawer: Drawer(
        // 记得要先添加 `SafeArea` 防止视图顶到状态栏下面
        child: SafeArea(
          child: HomeMenu(),
        ),
      ),
    );

    _checkLoginStatus();

    return scf;
  }

  void _checkLoginStatus() {
    // if (MeInfo().isLogined == true) {
    //   _getDataFromServer();
    //   return;
    // }

    Future.delayed(Duration(seconds: 2), () {
      if (MeInfo().isLogined == false) {
        Navigator.of(_scaffoldKey.currentContext).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      } else {
        _getDataFromServer();
      }
    });
  }
}
