import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'package:mes/Others/View/SimpleSelectionItemWidget.dart';

class PlanProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanProgressPageState();
  }
}

class _PlanProgressPageState extends State<PlanProgressPage> {
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "模具编码",
  );

  SimpleSelectionItemWidget _simpleSelectionWgt0;
  SimpleSelectionItemWidget _simpleSelectionWgt1;

  String content;
  final List<String> functionTitleList = [
    "锁定",
    "重启",
    "终止",
  ];
  List<Widget> bottomFunctionWidgetList = List();

  final List<bool> expansionList = [false, false, false];

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
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
              // _functionItemClickedAtIndex(i);
            },
          ),
        ),
      );
      bottomFunctionWidgetList.add(btn);

      if (i != (functionTitleList.length - 1)) {
        bottomFunctionWidgetList.add(SizedBox(width: 1));
      }
    }

    _simpleSelectionWgt0 = _buildSimpleSelectionItem(0);
    _simpleSelectionWgt1 = _buildSimpleSelectionItem(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("工单进度"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        WidgetTool.createListViewLine(5, hexColor("f2f2f7")),
        _buildDateFilterTopBar(),
        WidgetTool.createListViewLine(5, hexColor("f2f2f7")),
        _buildTopBar(),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.bottomFunctionWidgetList,
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilterTopBar() {
    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "生产日期：",
            style: TextStyle(fontSize: 15, color: hexColor("333333")),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _simpleSelectionWgt0,
                ),
                Text(" ~ ", style: TextStyle(fontSize: 13, color: hexColor("999999")),),
                Expanded(
                  child: _simpleSelectionWgt1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleSelectionItem(int index) {
    String c = "";
    if (index == 0) {
      c = "起止日期";
    } else if (index == 1) {
      c = "终止日期";
    }

    void Function() selectionBlock = () {
      _hasSelectedSimpleSelectionItem(index);
    };

    SimpleSelectionItemWidget wgt = SimpleSelectionItemWidget(height: 45, content: c, selectionBlock: selectionBlock,);

    return wgt;
  }

  void _hasSelectedSimpleSelectionItem(int index) {
    print("_hasSelectedSimpleSelectionItem: $index");
  }

  Widget _buildTopBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: MESSelectionItemWidget(enabled: true, title: "产线"),
          ),
          GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                // color: randomColor(),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: hexColor("999999"),
                ),
              ),
            ),
            onTap: () {
              _tryToSearch();
            },
          ),
        ],
      ),
    );
  }

  void _tryToSearch() {
    print("_tryToSearch");
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _buildHeader(),
        _buildSummaryCellItem(0),
        _buildDetailCellItem(shouldExpand: expansionList[0]),
        _buildSummaryCellItem(1),
        _buildDetailCellItem(shouldExpand: expansionList[1]),
        _buildSummaryCellItem(2),
        _buildDetailCellItem(shouldExpand: expansionList[2]),
      ],
    );
  }

  Widget _buildDetailCellItem({bool shouldExpand = false}) {
    if (shouldExpand) {
      return Container(
        height: 300,
        color: randomColor(),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget _buildSummaryCellItem(int index) {
    double progress = randomIntUntil(100) / 100.0;

    return Container(
      color: Colors.white,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              // color: randomColor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    // color: randomColor(),
                    child: Text(
                      "工单号：W0201912170019|1",
                      style: TextStyle(
                          color: hexColor("333333"),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: randomColor(),
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "物料：12233002",
                          style: TextStyle(
                            fontSize: 13,
                            color: hexColor("666666"),
                          ),
                        ),
                        Text(
                          "良品：返工：报废：",
                          style: TextStyle(
                            fontSize: 13,
                            color: hexColor("666666"),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            this.expansionList[index] == false ? Icons.more_horiz : Icons.expand_less,
                            color: hexColor(MAIN_COLOR),
                            size: 20,
                          ),
                          onTap: () {
                            print("more_horiz");                            
                            setState(() {

                              this.expansionList[index] = !this.expansionList[index];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 16,
                          child: LinearProgressIndicator(
                            backgroundColor: hexColor("eeeeee"),
                            valueColor:
                                AlwaysStoppedAnimation(hexColor(MAIN_COLOR)),
                            value: progress,
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 0,
                          child: Text(
                            "${progress * 100}%",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetTool.createListViewLine(1, hexColor("dddddd")),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: hexColor("f2f2f7"),
      padding: EdgeInsets.only(left: 10),
      height: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "工单明细信息",
            style: TextStyle(color: hexColor("333333"), fontSize: 13),
          )
        ],
      ),
    );
  }
}
