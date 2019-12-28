import 'package:flutter/material.dart';
import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'LoginInputItem.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String username = MeInfo().username;
  String password = MeInfo().password;
  bool shouldRememberMe = MeInfo().shouldRememberMe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Others/Images/Login-Background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        // width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor("ffffff")),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: hexColor(MAIN_COLOR),
              height: 80,
              child: Center(
                child: Text(
                  "智无形云平台",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            LoginInputItem(this.username, "用户名", false, EdgeInsets.fromLTRB(25, 25, 25, 0),
                (newText) {
              this.username = newText;
            }),
            LoginInputItem(this.password, "密码", true, EdgeInsets.fromLTRB(25, 25, 25, 0),
                (newText) {
              this.password = newText;
            }),
            Container(
              margin: EdgeInsets.fromLTRB(12, 10, 0, 0),
              color: Colors.white,
              height: 25,
              child: FlatButton.icon(
                icon: Icon((this.shouldRememberMe ? Icons.check_box : Icons.check_box_outline_blank)),
                label: Text(
                  "记住账户",
                  style: TextStyle(fontSize: 15, color: hexColor("333333")),
                ),
                onPressed: () {
                  print("记住账户");                  
                  setState(() {
                    this.shouldRememberMe = !this.shouldRememberMe;
                  });
                },
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
              // constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: randomColor(),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              padding: EdgeInsets.zero,
              child: FlatButton(
                textColor: Colors.white,
                color: hexColor("e68073"),
                child: Text(
                  "登陆",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print("登陆");
                  _tryToLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tryToLogin() {
    
     if (isAvailable(this.username) == false) {
       HudTool.showInfoWithStatus("请输入用户名");
       return;
     }

     if (isAvailable(this.password) == false) {
       HudTool.showInfoWithStatus("请输入密码");
       return;
     }

    hideKeyboard(context);

    HudTool.show();
    HttpDigger().postWithUri("Login/OutOnline", parameters: {"UserName":this.username, "Password":this.password}, success: (int code, String message, dynamic responseJson) {
      print("Login/OutOnline: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      Navigator.pop(_scaffoldKey.currentContext);
      
      HudTool.showInfoWithStatus(message);
      MeInfo().isLogined = true;
      MeInfo().shouldRememberMe = this.shouldRememberMe;
      MeInfo().username = this.username;
      MeInfo().password = this.password;
      MeInfo().nickname = responseJson["Category"];
      MeInfo().storeLoginInfo();      
    }, failure: (Error e) {
      HudTool.showInfoWithStatus("${e.toString()}");
    });
  }
}
