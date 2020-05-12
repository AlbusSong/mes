import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
// import 'package:mes/Others/Tool/WidgetTool.dart';

import 'Model/NotificationItemModel.dart';

class NotificationDetailPage extends StatelessWidget {
  NotificationDetailPage(
    this.data,
  );

  final NotificationItemModel data;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> detailInfoList;

  void _getDataFromServer() {
    // Push/SetPushStatus
    Map mDict = Map();
    mDict["pushCode"] = this.data.PushCode;
    this.detailInfoList = this.data.PushText.split("|");

    HudTool.show();
    HttpDigger().postWithUri("Push/SetPushStatus", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Push/SetPushStatus: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getDataFromServer();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("通知详情"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _buildDetailTitleCell(),
        _buildDetailContentCell(),
      ],
    );
  }

  Widget _buildDetailTitleCell() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${_getPushTypeStringBy(this.data.PushType)} ${this.data.PushFunctionCode}",
            style: TextStyle(
                color: hexColor("333333"),
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          // Text(
          //   "操作人：Horo",
          //   style: TextStyle(color: hexColor("333333"), fontSize: 14),
          // )
        ],
      ),
    );
  }

  String _getPushTypeStringBy(int pushType) {
    String result = "产线异常";
    if (pushType == 1) {
      result = "锁定退料";
    } else if (pushType == 2) {
      result = "巡检异常";
    } else if (pushType == 3) {
      result = "自检异常";
    } else if (pushType == 4) {
      result = "点检异常";
    }
    return result;
  }

  Widget _buildDetailContentCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            child: Text(
              "待处理异常信息：",
              style: TextStyle(color: hexColor("333333"), fontSize: 18),
            ),
          ),
          Container(
            constraints: BoxConstraints(minHeight: 30),
            child: Text(
              "产线：${this.data.PushSubject}                项目：${this.detailInfoList[0]}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "工序：${this.detailInfoList[1]}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "机型：${this.detailInfoList[2]}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "标准：${this.detailInfoList[3]}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "实际测量结果：${this.detailInfoList[4]}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
