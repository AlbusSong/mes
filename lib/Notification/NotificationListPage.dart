import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';

import 'NotificationDetailPage.dart';

import 'Model/NotificationItemModel.dart';

class NotificationListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationListPageState();
  }
}

class _NotificationListPageState extends State<NotificationListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List arrOfData = List();

  @override
  void initState() {
    super.initState();

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // Push/GetPushSubject
    Map mDict = Map();
    // mDict["wono"] = "";
    // mDict["item"] = "";
    // mDict["tag"] = "";
    // mDict["id"] = "";

    HudTool.show();
    HttpDigger().postWithUri("Push/GetPushSubject", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Push/GetPushSubject: $responseJson");

      HudTool.dismiss();
      List arr = (responseJson["Extend"]as List)
          .map((item) => NotificationItemModel.fromJson(item))
          .toList();

      this.arrOfData.clear();
      if (listLength(arr) == 0) {        
        setState(() {        
        });
        return;
      }      

      String currentDateString = "";
      List subitemsInSameDay = List();
      Map oneDayItem;      
      for (int i = 0; i < listLength(arr); i++) {
        NotificationItemModel model = arr[i];
        DateTime d = DateTime.parse(model.CreateTime);
        String dateString = formatDate(d, [yyyy, '-', mm, '-', dd]);
        if (dateString != currentDateString) {
          currentDateString = dateString;
          oneDayItem = Map();
          oneDayItem["date"] = currentDateString;
          subitemsInSameDay = List();
          subitemsInSameDay.add(model);
          oneDayItem["items"] = subitemsInSameDay;
          this.arrOfData.add(oneDayItem);          
        } else {
          subitemsInSameDay.add(model);
        }
      }

      setState(() {        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("通知列表"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: hexColor("f2f2f7"),
            child: _buildListView(),
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        itemBuilder: (context, index) {
          return _buildListItem(index);
        });
  }

  Widget _buildListItem(int index) {
    List<Widget> childernWidgets = [_buildDateHeaderCell(index)];
    Map oneDayDict = this.arrOfData[index];
    List subitemsInSameDay = (oneDayDict["items"] as List);
    for (int i = 0; i < listLength(subitemsInSameDay); i++) {
      Widget notificationItem = _buildNotificationItemCell(index, i);
      childernWidgets.add(notificationItem);
    }
    return Container(
      color: randomColor(),
      child: Column(
        children: childernWidgets,
      ),
    );
  }

  void _hasSelectedNotificationItemCell(int index, int subIndex) {
    Map oneDayDict = this.arrOfData[index];
    List subitemsInSameDay = (oneDayDict["items"] as List);
    NotificationItemModel itemData = subitemsInSameDay[subIndex];
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => NotificationDetailPage(itemData)));
  }

  Widget _buildNotificationItemCell(int index, int subIndex) {
    Map oneDayDict = this.arrOfData[index];
    List subitemsInSameDay = (oneDayDict["items"] as List);
    NotificationItemModel itemData = subitemsInSameDay[subIndex];
    return GestureDetector(
      onTap: () {
        print("index: $index, subIndex: $subIndex");
        _hasSelectedNotificationItemCell(index, subIndex);
      },
      child: Container(
      height: 80,
      color: subIndex % 2 == 0 ? Colors.white : hexColor("eaeaee"),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getPushTypeStringBy(itemData.PushType), style: TextStyle(color: hexColor("333333"), fontSize: 16),),
            Text("推送号 ${itemData.PushFunctionCode} ${itemData.PushSubject}", style: TextStyle(color: hexColor("666666")),),
          ],
        ),
      ),
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

  Widget _buildDateHeaderCell(int index) {
    Map oneDayDict = this.arrOfData[index];
    return Container(
      height: 40,
      color: hexColor("f1f1f7"),
      padding: EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            oneDayDict["date"],
            style: TextStyle(color: hexColor("555555"), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
