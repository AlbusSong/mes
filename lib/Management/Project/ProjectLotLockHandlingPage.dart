import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/View/SearchBar.dart';

class ProjectLotLockHandlingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotLockHandlingPageState();
  }
}

class _ProjectLotLockHandlingPageState
    extends State<ProjectLotLockHandlingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchBar _sBar = SearchBar(
    hintText: "产线代码",
  );

  List<Widget> bottomFunctionWidgetList = List();
  final List<String> functionTitleList = [
    "解锁",
    "返修",
    "报废",
  ];

  @override
  void initState() {
    super.initState();

    _sBar.keyboardReturnBlock = (String c) {
      _getDataFromServer();
    };

    for (int i = 0; i < functionTitleList.length; i++) {
      String functionTitle = functionTitleList[i];
      Widget btn = Expanded(
        child: Container(
          height: 50,
          color: hexColor(MAIN_COLOR),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text(functionTitle),
            onPressed: () {
              print(functionTitle);
              _functionItemClickedAtIndex(i);
            },
          ),
        ),
      );
      bottomFunctionWidgetList.add(btn);

      if (i != (functionTitleList.length - 1)) {
        bottomFunctionWidgetList.add(SizedBox(width: 1));
      }
    }
  }

  void _getDataFromServer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot锁定"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
    ;
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _sBar,
        Expanded(
          child: Container(
            color: hexColor("f2f2f7"),
            // child: _buildListView(),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          // color: randomColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.bottomFunctionWidgetList,
          ),
        ),
      ],
    );
  }

  Future _functionItemClickedAtIndex(int index) async {}
}
