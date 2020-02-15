import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/SearchBar.dart';

class QualitySelfTestWorkOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualitySelfTestWorkOrderPageState();
  }
}

class _QualitySelfTestWorkOrderPageState extends State<QualitySelfTestWorkOrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchBar _sBar = SearchBar(
    hintText: "产线代码",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("自检工单"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _sBar,
        Expanded(
          child: Container(
            color: hexColor("f2f2f7"),
            child: _buildListView(),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          // color: randomColor(),
          child: FlatButton(
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text("确认"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        // itemCount: listLength(this.arrOfData),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }  

  Widget _buildListItem(int index) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    height: 25,
                    color: Colors.white,
                    child: Text(
                      "CPX|完成线",
                      maxLines: 2,
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR_BLACK),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("工序：绝缘耐压抵抗检测",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("工单号：MECWO20191211012",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("下发时间：15:20",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("类型：定期自检",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: hexColor("dddddd"),
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(right: 8),
            color: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: hexColor("dddddd"),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {

  }

  void _btnConfirmClicked() {
    
  }
}