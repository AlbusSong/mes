import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/SearchBar.dart';

class QualityPatrolTestWorkOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualityPatrolTestWorkOrderPageState();
  }
}

class _QualityPatrolTestWorkOrderPageState extends State<QualityPatrolTestWorkOrderPage> {
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
        title: Text("巡检工单"),
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
      color: randomColor(),
      height: 100,
    );
  }

  void _hasSelectedIndex(int index) {

  }

  void _btnConfirmClicked() {
    
  }
}