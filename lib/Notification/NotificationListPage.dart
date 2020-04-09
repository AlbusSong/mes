import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';

import 'NotificationDetailPage.dart';

class NotificationListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationListPageState();
  }
}

class _NotificationListPageState extends State<NotificationListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List arrOfData = [
    [1, 2, 3],
    [2, 3],
    [3],
    [4, 5]
  ];

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
    List notificationSection = this.arrOfData[index];
    for (int i = 0; i < listLength(notificationSection); i++) {
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
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => NotificationDetailPage()));
  }

  Widget _buildNotificationItemCell(int index, int subIndex) {
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
            Text("巡检异常", style: TextStyle(color: hexColor("333333"), fontSize: 16),),
            Text("工单号 IPQEWKD0193920293 异常", style: TextStyle(color: hexColor("666666")),),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildDateHeaderCell(int index) {
    return Container(
      height: 40,
      color: hexColor("f1f1f7"),
      padding: EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "2020-04-08",
            style: TextStyle(color: hexColor("555555"), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
