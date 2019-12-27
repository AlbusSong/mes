import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';

class ProjectInfoDisplayWidget extends StatelessWidget {
  ProjectInfoDisplayWidget({
    this.title = "",
    this.content = "-",
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            height: 15,
            child: Text(
              "标题",
              style: TextStyle(color: hexColor(MAIN_COLOR_BLACK), fontSize: 10),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: hexColor("d3d3d3"),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                    this.content,
                    style: TextStyle(color: hexColor("333333"), fontSize: 12),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
