import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/MESSelectionItemWidget.dart';
import 'package:mes/Others/View/SimpleSelectionItemWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';

import 'package:mes/Management/Project/Model/ProjectLineModel.dart';
import 'package:mes/Management/Plan/Model/PlanProcessItemModel.dart';

class PlanProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanProgressPageState();
  }
}

class _PlanProgressPageState extends State<PlanProgressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SimpleSelectionItemWidget _simpleSelectionWgt0;
  SimpleSelectionItemWidget _simpleSelectionWgt1;

  MESSelectionItemWidget _selectionWgt0;

  String content;
  String startDateString;
  String endDateString;
  final List<String> functionTitleList = [
    "暂停",
    "重启",
    "终止",
  ];
  List<Widget> bottomFunctionWidgetList = List();

  List arrOfLineItem;
  ProjectLineModel selectedLineItem;
  List<bool> expansionList = List();
  List arrOfData;
  int selectedIndex;

  @override
  void initState() {
    super.initState();

    this.selectedIndex = -1;

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

    _simpleSelectionWgt0 = _buildSimpleSelectionItem(0);
    _simpleSelectionWgt1 = _buildSimpleSelectionItem(1);
    _selectionWgt0 = _buildSelectionInputItem(0);

    _getLineDataFromServer();
  }

  void _getLineDataFromServer() {
    // 获取所有有效的产线
    HttpDigger()
        .postWithUri("LoadMaterial/AllLine", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/AllLine: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      this.arrOfLineItem = (responseJson['Extend'] as List)
          .map((item) => ProjectLineModel.fromJson(item))
          .toList();
    });
  }

  void _getProgressListFromServer() {
    // LoadPlanProcess/LoadPlanProcess
    Map mDict = Map();
    if (this.selectedLineItem != null) {
      mDict["LineCode"] = this.selectedLineItem.LineCode;
    }
    if (isAvailable(this.startDateString)) {
      mDict["WoStartDate"] = this.startDateString;
    }
    if (isAvailable(this.endDateString)) {
      mDict["WoEndDate"] = this.endDateString;
    }

    HudTool.show();
    HttpDigger().postWithUri("LoadPlanProcess/LoadPlanProcess",
        parameters: mDict, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LoadPlanProcess/LoadPlanProcess: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => PlanProcessItemModel.fromJson(item))
          .toList();
      this.expansionList.clear();
      for (int i = 0; i < listLength(this.arrOfData); i++) {
        this.expansionList.add(false);
      }

      setState(() {});
    });
  }

  Future _functionItemClickedAtIndex(int index) async {
    if (this.selectedIndex < 0) {
      HudTool.showInfoWithStatus("请选择一项");
      return;
    }

    String hintText = "";
    if (index == 0) {
      hintText = "确定暂停？";
    } else if (index == 1) {
      hintText = "确定重启？";
    } else if (index == 2) {
      hintText = "确定终止？";
    }

    bool isOkay = await AlertTool.showStandardAlert(
        _scaffoldKey.currentContext, hintText);

    if (isOkay) {
      _realConfirmationAction(index);
    }
  }

  void _realConfirmationAction(int index) {
    String uri = "";
    if (index == 0) {
      uri = "LoadPlanProcess/PauseWo";
    } else if (index == 1) {
      uri = "LoadPlanProcess/RestartWo";
    } else if (index == 2) {
      uri = "LoadPlanProcess/StopWo";
    }

    PlanProcessItemModel selectedItem = this.arrOfData[index];
    Map mDict = {"Wono": selectedItem.Wono};
    print("$uri mDict: $mDict");
    HudTool.show();    
    HttpDigger().postWithUri(uri, parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
      print("$uri: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                Text(
                  " ~ ",
                  style: TextStyle(fontSize: 13, color: hexColor("999999")),
                ),
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

    SimpleSelectionItemWidget wgt = SimpleSelectionItemWidget(
      height: 45,
      content: c,
      selectionBlock: selectionBlock,
    );

    return wgt;
  }

  void _hasSelectedSimpleSelectionItem(int index) {
    print("_hasSelectedSimpleSelectionItem: $index");

    _showDatePicker(index);
  }

  void _showDatePicker(int index) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(),
        title: Text("选择日期"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List indexOfSelectedItems) {
          print(indexOfSelectedItems);
          this._handleDatePickerConfirmation(indexOfSelectedItems, index);
        }).showDialog(context);
  }

  void _handleDatePickerConfirmation(List indexOfSelectedItems, int index) {
    int month = indexOfSelectedItems[0] + 1;
    int day = indexOfSelectedItems[1] + 1;
    int year = indexOfSelectedItems[2] + 1900;
    String year_month_day = "$year-$month-$day";
    if (index == 0) {
      _simpleSelectionWgt0.setContent(year_month_day);
      this.startDateString = year_month_day;
    } else {
      _simpleSelectionWgt1.setContent(year_month_day);
      this.endDateString = year_month_day;
    }
  }

  Widget _buildTopBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _selectionWgt0,
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

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    if (index == 0) {
      title = "产线";
    }
    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget wgt = MESSelectionItemWidget(
      title: title,
      enabled: enabled,
    );
    wgt.selectionBlock = selectionBlock;
    return wgt;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");

    List<String> arrOfSelectionTitle = [];
    for (ProjectLineModel m in this.arrOfLineItem) {
      arrOfSelectionTitle.add('${m.LineCode}|${m.LineName}');
    }

    if (arrOfSelectionTitle.length == 0) {
      return;
    }

    _showPickerWithData(arrOfSelectionTitle, index);

    hideKeyboard(context);
  }

  void _showPickerWithData(List<String> listData, int index) {
    Picker picker = new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: listData),
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List indexOfSelectedItems) {
          print(indexOfSelectedItems.first);
          print(picker.getSelectedValues());
          this._handlePickerConfirmation(indexOfSelectedItems.first,
              picker.getSelectedValues().first, index);
        });
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedLineItem = this.arrOfLineItem[indexOfSelectedItem];

      _selectionWgt0.setContent(title);
    }
  }

  void _tryToSearch() {
    print("_tryToSearch");

    _getProgressListFromServer();
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData) * 2 + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          } else {
            int realIndex = ((index - 1) / 2.0).floor();
            if ((index - 1) % 2 == 0) {
              return GestureDetector(
                child: _buildListItem(realIndex),
                onTap: () => _hasSelectedIndex(realIndex),
              );
            } else {
              return _buildDetailCellItem(realIndex);
            }
          }
        });
  }

  Widget _buildDetailCellItem(int index) {
    PlanProcessItemModel itemData = this.arrOfData[index];
    bool shouldExpand = this.expansionList[index];
    if (shouldExpand) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: hexColor("f5f8f7"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _generateDetailWidgetList(itemData),
        ),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  List<Widget> _generateDetailWidgetList(PlanProcessItemModel itemData) {
    const detailTitleList = const [
      "订单号",
      "纳期",
      "开始时间",
      "结束时间",
      "部品名",
      "型号规格",
      "版本",
      "发行日期",
      "计划量"
    ];

    List<Widget> result = List();
    for (int i = 0; i < detailTitleList.length; i++) {
      String title = "";
      if (i == 0) {
        // 订单号
        title = "${detailTitleList[i]}：${avoidNull(itemData.Pdno)}";
      } else if (i == 1) {
        // 纳期
        title = "${detailTitleList[i]}：${avoidNull(itemData.PdFTime)}";
      } else if (i == 2) {
        // 开始时间
        title = "${detailTitleList[i]}：${avoidNull(itemData.WoStartDate)}";
      } else if (i == 3) {
        // 结束时间
        title = "${detailTitleList[i]}：${avoidNull(itemData.Pdno)}";
      } else if (i == 4) {
        // 部品名
        title = "${detailTitleList[i]}：${avoidNull(itemData.ItemName)}";
      } else if (i == 5) {
        // 型号规格
        title = "${detailTitleList[i]}：${avoidNull(itemData.ItemName)}";
      } else if (i == 6) {
        // 版本
        title = "${detailTitleList[i]}：${avoidNull(itemData.BopVersion)}";
      } else if (i == 7) {
        // 发行日期
        title = "${detailTitleList[i]}：${avoidNull(itemData.Pdno)}";
      } else if (i == 8) {
        // 计划量
        title =
            "计划量：${itemData.WoPlanQty.round()}    实绩：${itemData.WoOutPutQty.round()}    良品：${itemData.WoGoodQty.round()}    返工：${itemData.WoReturnQty.round()}    报废：${itemData.WoScrapQty.round()} ";
      }
      Text txt = Text(
        title,
        style: TextStyle(fontSize: 12, color: hexColor("999999")),
      );
      result.add(txt);
    }

    return result;
  }

  bool _checkIfSelected(int index) {
    return this.selectedIndex == index;
  }

  void _hasSelectedIndex(int index) {
    if (this.selectedIndex == index) {
      return;
    }

    this.selectedIndex = index;

    setState(() {});
  }

  Widget _buildListItem(int index) {
    PlanProcessItemModel itemData = this.arrOfData[index];
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
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        color: Colors.white,
                        child: Icon(
                          _checkIfSelected(index) == true
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: _checkIfSelected(index) == true
                              ? hexColor(MAIN_COLOR)
                              : hexColor("dddddd"),
                          size: 20,
                        ),
                      ),
                      Container(
                        height: 20,
                        // color: randomColor(),
                        child: Text(
                          "${itemData.Wono}|${itemData.ProcessName}|${itemData.Shift}|${itemData.StateDesc}",
                          style: TextStyle(
                              color: hexColor("333333"),
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "物料：${itemData.ItemCode}",
                          style: TextStyle(
                            fontSize: 13,
                            color: hexColor("666666"),
                          ),
                        ),
                        Text(
                          "计划量：${itemData.WoPlanQty.round()}",
                          style: TextStyle(
                            fontSize: 13,
                            color: hexColor("666666"),
                          ),
                        ),
                        Text(
                          "实绩：${itemData.WoGoodQty.round()}",
                          style: TextStyle(
                            fontSize: 13,
                            color: hexColor("666666"),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            this.expansionList[index] == false
                                ? Icons.more_horiz
                                : Icons.expand_less,
                            color: hexColor(MAIN_COLOR),
                            size: 20,
                          ),
                          onTap: () {
                            print("more_horiz");
                            setState(() {
                              this.expansionList[index] =
                                  !this.expansionList[index];
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
                            value: (itemData.CompRate / 100.0),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 0,
                          child: Text(
                            "${itemData.CompRate}%",
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
