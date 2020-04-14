import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/MESSelectionItemWidget.dart';

import 'Model/PlanMaterialItemModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class PlanMaterialAcceptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanMaterialAcceptionPageState();
  }
}

class _PlanMaterialAcceptionPageState extends State<PlanMaterialAcceptionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MESSelectionItemWidget _selectionWgt0;

  String progressStateDesc;

  List arrOfData;
  List<bool> expansionList = List();
  int selectedIndex;

  @override
  void initState() {
    super.initState();

    this.selectedIndex = -1;

    _selectionWgt0 = _buildSelectionInputItem(0);
  }

  void _getDataFromServer() {
    Map mDict = Map();
    if (isAvailable(this.progressStateDesc) == true) {
      mDict["State"] = this.progressStateDesc;
    }

    HudTool.show();
    HttpDigger().postWithUri("LoadPlanProcess/SearchExportOrder",
        parameters: mDict, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LoadPlanProcess/SearchExportOrder: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => PlanMaterialItemModel.fromJson(item))
          .toList();
      this.expansionList.clear();
      for (int i = 0; i < listLength(this.arrOfData); i++) {
        this.expansionList.add(false);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("物料接收"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
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
          child: FlatButton(
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text("接收"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Future _btnConfirmClicked() async {
    if (this.selectedIndex < 0) {
      HudTool.showInfoWithStatus("请选择一项");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(
        _scaffoldKey.currentContext, "确定接收？");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    // LoadPlanProcess/Receive       
    HudTool.show();

    PlanMaterialItemModel selectedItemData = this.arrOfData[this.selectedIndex]; 
    HttpDigger().postWithUri("LoadPlanProcess/Receive", parameters: {"Rpno": selectedItemData.ExportNo}, success: (int code, String message, dynamic responseJson) {
      print("LoadPlanProcess/Receive: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
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

    hideKeyboard(context);

    _getDataFromServer();
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

  Widget _buildDetailCellItem(int index) {
    bool shouldExpand = this.expansionList[index];
    PlanMaterialItemModel itemData = this.arrOfData[index];
    if (shouldExpand) {
      return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("需求仓库：${itemData.DestWareHouseID}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("需求日期：${itemData.NeedDate}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("出库时间：${itemData.AprTime}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("接受时间：${itemData.ReceiveTime}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("配料员：${itemData.Approver}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("产线：${itemData.Line}|${itemData.LineName}", style: TextStyle(color: hexColor("666666"), fontSize: 13),)
          ],
        ));
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget _buildListItem(int index) {
    PlanMaterialItemModel itemData = this.arrOfData[index];
    return Container(
      height: 60,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      color: Colors.white,
                      child: Icon(
                        _checkIfSelected(index) == true ? Icons.check_box : Icons.check_box_outline_blank,
                        color:
                            _checkIfSelected(index) == true ? hexColor(MAIN_COLOR) : hexColor("dddddd"),
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        // color: randomColor(),
                        child: Text(
                          "${itemData.ExportNo}|${itemData.PrepareTime}|${itemData.State}",
                          style: TextStyle(
                              color: hexColor("666666"),
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
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
                )),
          ),
          WidgetTool.createListViewLine(1, hexColor("dddddd")),
        ],
      ),
    );
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    if (index == 0) {
      title = "进度";
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

    List<String> arrOfSelectionTitle = ["待接收"];

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
      this.progressStateDesc = title;

      _selectionWgt0.setContent(title);
    }
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
            "领料单｜备料时间｜进度",
            style: TextStyle(color: hexColor("333333"), fontSize: 13),
          )
        ],
      ),
    );
  }
}
