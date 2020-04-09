import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
// import 'package:mes/Others/Tool/WidgetTool.dart';

class NotificationDetailPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            "工单号 PQED32382838283 异常",
            style: TextStyle(
                color: hexColor("333333"),
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "操作人：Horo",
            style: TextStyle(color: hexColor("333333"), fontSize: 14),
          )
        ],
      ),
    );
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
              "产线：活塞线                项目：垂直度",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "工序：活塞捡漏",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "机型：活塞1Y38XD",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "标准：2～3MM",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "实际测量结果：4MM",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
