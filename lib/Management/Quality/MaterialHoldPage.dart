import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';

import '../Project/Widget/ProjectTextInputWidget.dart';

import 'Model/QualityMaterialHoldItemModel.dart';

class MaterialHoldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterialHoldPageState();
  }  
}

class _MaterialHoldPageState extends State<MaterialHoldPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProjectTextInputWidget _pTextInputWgt0;
  ProjectTextInputWidget _pTextInputWgt1;
  ProjectTextInputWidget _pTextInputWgt2;

  String batchNo = "20190111";
  String itemCode = "";
  String tagNo = "";
  String remarkContent;
  List arrOfData;
  List<bool> expansionList = List();
  List<bool> selectionList = List();
  bool allItemsAreSelected = false;

  @override
  void initState() {
    super.initState();

    this.batchNo = formatDate(DateTime.now(), ["yyyy", "mm", "dd"]);

    _pTextInputWgt0 = _buildTextInputWidgetItem(0);
    _pTextInputWgt1 = _buildTextInputWidgetItem(1);
    _pTextInputWgt2 = _buildTextInputWidgetItem(2);

    _pTextInputWgt0.setContent(this.batchNo);
    _pTextInputWgt1.setContent(this.itemCode);
    _pTextInputWgt2.setContent(this.tagNo);    

    _getDataFromServer();    
  }

  void _getDataFromServer() {
    // LoadPlanProcess/SearchTagInfo
    Map mDict = Map();
    mDict["ItemCode"] = this.itemCode;
    mDict["TagID"] = this.tagNo;
    mDict["Batch"] = this.batchNo;

    HudTool.show();
    HttpDigger().postWithUri("LoadPlanProcess/SearchTagInfo",
        parameters: mDict, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LoadPlanProcess/SearchTagInfo: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => QualityMaterialHoldItemModel.fromJson(item))
          .toList();
      this.expansionList.clear();
      this.selectionList.clear();
      this.allItemsAreSelected = false;
      for (int i = 0; i < listLength(this.arrOfData); i++) {
        this.expansionList.add(false);
        this.selectionList.add(false);
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
        title: Text("原材料Hold"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _pTextInputWgt0,
        _pTextInputWgt1,
        Container(
          color: Colors.white,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _pTextInputWgt2,
            ),
            SizedBox(width: 80,)        ,
            IconButton(
              icon: Icon(                
              Icons.search,
              size: 30,
              color: hexColor("999999"),
            ),
              // iconSize: 24, 
              onPressed: (){
                _tryToSearch();
              },
            ),
            SizedBox(width: 10,)
          ],
        ),
        ),
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
            child: Text("锁定"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    String title = "";
    String placeholder = "";
    TextInputType keyboardType = TextInputType.text;
    if (index == 0) {
      title = "批次号";
      placeholder = "输入批次号";
    } else if (index == 1) {
      title = "材料代码";
      placeholder = "输入材料代码";
    } else if (index == 2) {
      title = "标签编号";
      placeholder = "输入标签编号";
    }
    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: false,
      keyboardType: keyboardType,
    );

    wgt.contentChangeBlock = (String newContent) {
      print("contentChangeBlock: $newContent");
      if (index == 0) {
        this.batchNo = newContent;
      } else if (index == 1) {
        this.itemCode = newContent;
      } else if (index == 2) {
        this.tagNo = newContent;
      }
    };

    return wgt;
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

  Widget _buildHeader() {
    return Container(
      color: hexColor("f2f2f7"),
      padding: EdgeInsets.only(left: 10),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
                      margin: EdgeInsets.only(right: 8),
                      color: Colors.white,
                      child: Icon(
                        this.allItemsAreSelected ? Icons.check_box : Icons.check_box_outline_blank,
                        color:
                            this.allItemsAreSelected ? hexColor(MAIN_COLOR) : hexColor("dddddd"),
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      _allItemsCheckBoxClicked();
                    },
          ),
          Text(
            "标签编号｜材料明晨｜标签状态",
            style: TextStyle(color: hexColor("333333"), fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    QualityMaterialHoldItemModel itemData = this.arrOfData[index];
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
                          "${itemData.TagID} | ${itemData.ItemCode} | ${itemData.State}",
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

  Widget _buildDetailCellItem(int index) {
    bool shouldExpand = this.expansionList[index];
    QualityMaterialHoldItemModel itemData = this.arrOfData[index];
    if (shouldExpand) {
      return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("材料名称：${itemData.ItemName}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("所在仓库：${itemData.WareHouseID}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("仓库名称：${itemData.Dsca}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("入库批次号：${itemData.Batch}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("入库日期：${itemData.CreateTime}", style: TextStyle(color: hexColor("666666"), fontSize: 13),),
            Text("出库日期：", style: TextStyle(color: hexColor("666666"), fontSize: 13),)
          ],
        ));
    } else {
      return Container(
        height: 1,
      );
    }
  }

  bool _checkIfSelected(int index) {
    bool selectionStatusAtIndex = this.selectionList[index];
    return selectionStatusAtIndex;
  }

  void _hasSelectedIndex(int index) {
    bool selectionStatusAtIndex = this.selectionList[index];

    selectionStatusAtIndex = !selectionStatusAtIndex;

    this.selectionList[index] = selectionStatusAtIndex;

    bool hasCheckedAll = true;
    bool hasUnckeckedAll = true;
    for (int i = 0; i < listLength(this.selectionList); i++) {
      bool selectionStatus = this.selectionList[i];
      if (selectionStatus == true) {
        hasUnckeckedAll = false;
      } else {
        hasCheckedAll = false;
      }
    }

    if (hasCheckedAll) {
      this.allItemsAreSelected = true;
    }
    if (hasUnckeckedAll) {
      this.allItemsAreSelected = false;
    }

    setState(() {});
  }

  void _allItemsCheckBoxClicked() {
    this.allItemsAreSelected = !this.allItemsAreSelected;

    for (int i = 0; i < listLength(this.selectionList); i++) {
      this.selectionList[i] = this.allItemsAreSelected;
    }

    setState(() {      
    });
  }

  void _tryToSearch() {
    print("_tryToSearch");

    hideKeyboard(context);

    _getDataFromServer();
  }

  Future _btnConfirmClicked() async {
    List selectedItems = List();
    for (int i = 0; i < listLength(this.selectionList); i++) {
      bool selectionStatus = this.selectionList[i];
      if (selectionStatus == false) {
        continue;
      }
      QualityMaterialHoldItemModel item = this.arrOfData[i];
      selectedItems.add(item);
    }

    if (listLength(selectedItems) == 0) {
      HudTool.showInfoWithStatus("请至少选择一项");
      return;
    }

    Map resultDict = await AlertTool.showInputFeildAlert(_scaffoldKey.currentContext, "确定锁定?", placeholder: "请输入备注信息");
    this.remarkContent = resultDict["text"];
    if (isAvailable(this.remarkContent) == false) {
      HudTool.showInfoWithStatus("需要输入备注信息");
      return;
    }

    if (resultDict["confirmation"] == true) {
      _realConfirmationAction(selectedItems);
    }
  }

  void _realConfirmationAction(List selectedItems) {
    // LoadPlanProcess/LockTag
    String tagIDString = "";
    String itemCodeString = "";
    for (int i = 0; i < listLength(selectedItems); i++) {
      QualityMaterialHoldItemModel item = selectedItems[i];
      itemCodeString = item.ItemCode;
      if (i == listLength(selectedItems) - 1) {
        // 如果是最后一个元素
        tagIDString += item.TagID;
      } else {
        tagIDString += "${item.TagID},";
      }
      print("tagIDString: $tagIDString");
    }

    Map mDict = Map();
    mDict["TagID"] = tagIDString;
    mDict["ItemCode"] = itemCodeString;
    mDict["Batch"] = this.batchNo;
    mDict["Remark"] = this.remarkContent;

    HudTool.show();
    HttpDigger().postWithUri("LoadPlanProcess/LockTag", parameters: mDict, success: (int code, String message, dynamic responseJson) {
      print("LoadPlanProcess/LockTag: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }
}