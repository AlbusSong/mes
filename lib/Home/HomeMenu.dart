import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Login/LoginPage.dart';
import '../Management/Mold/MoldPage.dart';
import '../Management/ProductLine/ProductLinePage.dart';

class HomeMenu extends StatefulWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  static Color backgroundColor = hexColor("f2f2f7");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListView(
        children: <Widget>[
          WidgetTool.createListViewLine(40, backgroundColor),
          _menuPortraitItem(),
          WidgetTool.createListViewLine(20, backgroundColor),
          _menuFunctionItem("注销", 0),
          WidgetTool.createListViewLine(25, backgroundColor),
          _menuHeaderTitle(),
          _menuFunctionItem("工程管理", 1),
          WidgetTool.createListViewLine(1, backgroundColor),
          _menuFunctionItem("计划管理", 2),
          WidgetTool.createListViewLine(1, backgroundColor),
          _menuFunctionItem("产线管理", 3),
          WidgetTool.createListViewLine(1, backgroundColor),
          _menuFunctionItem("品质管理", 4),
          WidgetTool.createListViewLine(1, backgroundColor),
          _menuFunctionItem("模具管理", 5),
        ],
      ),
    );
  }

  Future _functionItemClickedAtIndex(int index) async {
    print("_functionItemClickedAtIndex: $index");
    // Navigator.of(context).pop();
    if (index == 0) {
      {
        bool shouldLogout = await _showLogoutDialog();
        if (shouldLogout) {
          print("shouldLogout: $shouldLogout");
          MeInfo().isLogined = false;
          MeInfo().storeLoginInfo();
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
        }
      }
    } else if (index == 1) {
      if (MeInfo().isLogined == false) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        return;
      }
      // Navigator.of(context).pop();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) => HomeFunctionModules()));
    } else if (index == 2) {

    } else if (index == 3) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProductLinePage()));
    } else if (index == 5) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MoldPage()));
    }
  }

  Future<bool> _showLogoutDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("注销？"),
          content: Text("您确定要注销吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(false), //关闭对话框
            ),
            FlatButton(
              child: Text("注销"),
              onPressed: () {
                Navigator.of(context).pop(true); //关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  Widget _menuHeaderTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
      child: Text(
        "功能模块",
        style: TextStyle(fontSize: 13, color: hexColor("999999")),
      ),
    );
  }

  Widget _menuFunctionItem(String functionTitle, [int index = -1]) {
    return GestureDetector(
        onTap: () => _functionItemClickedAtIndex(index),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  functionTitle,
                  style: TextStyle(
                      color: hexColor(MAIN_COLOR_BLACK),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
              // Spacer(flex: 2),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: hexColor("999999"),
                    size: 16,
                  )),
            ],
          ),
        ));
  }

  Widget _menuPortraitItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: hexColor("dddddd"),
              backgroundImage: AssetImage("Others/Images/home_menu_user_portrait_icon.png"),
            ),
          ),
          Container(
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text(avoidNull(MeInfo().username),
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text(avoidNull(MeInfo().nickname),
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
