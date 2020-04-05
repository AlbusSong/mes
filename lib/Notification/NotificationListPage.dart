import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';

class NotificationListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationListPageState();
  }
}

class _NotificationListPageState extends State<NotificationListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Container(
      
    );
  }
}