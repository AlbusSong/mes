import 'package:flutter/material.dart';
import 'GlobalTool.dart';

class AlertTool {
  static Future<bool> showStandardAlert(BuildContext context, String title, {String message, String leftActionTitle = "取消", String rightActionTitle = "确定"}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: (message == null || message == "") ? null : Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(leftActionTitle),
              onPressed: () => Navigator.of(context).pop(false), //关闭对话框
            ),
            FlatButton(
              child: Text(rightActionTitle),
              onPressed: () {
                Navigator.of(context).pop(true); //关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Map<String, dynamic>> showInputFeildAlert(BuildContext context, String title, {String message, String placeholder, String leftActionTitle = "取消", String rightActionTitle = "确定"}) async {
    Map<String, dynamic> resultDict = {"confirmation":false, "text":""};
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          // content: (message == null || message == "") ? null : Text(message),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            height: 40,
            color: hexColor("f2f2f7"),
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(hintText: avoidNull(placeholder), contentPadding: EdgeInsets.only(top: -8), border: InputBorder.none),
              onChanged: (String text) {
                print("textChanged: $text");
                resultDict["text"] = text;
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(leftActionTitle),
              onPressed: () => Navigator.of(context).pop(resultDict), //关闭对话框
            ),
            FlatButton(
              child: Text(rightActionTitle),
              onPressed: () {
                resultDict["confirmation"] = true;
                Navigator.of(context).pop(resultDict); //关闭对话框
              },
            ),
          ],
        );
      },
    );
  }
}