import 'package:flutter/material.dart';
import '../../Others/Tool/AlertTool.dart';
import '../../Others/Network/HttpDigger.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import '../../Others/View/MESConntenInputWidget.dart';

import 'Model/MoldLockCodeModel.dart';

class MoldLockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldLockPageState();  
  }
}

class _MoldLockPageState extends State<MoldLockPage> {

  final SearchBarWithFunction _sBar = SearchBarWithFunction(hintText: "模具编码",);
  Map responseJson = Map();
  String content;
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  List<MoldLockCodeModel> arrOfData;

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
    };

    for (int i = 0; i < 5; i++) {
      this.selectionItemList.add(_buildSelectionItem(i));
    }

    _getDataFromServer();
  }

  void _getDataFromServer() {
    HttpDigger().postWithUri("Mould/LoadMould",
        parameters: {"mouldCode": "D0D201910250001"},
        success: (int code, String message, dynamic responseJson) {
      print("Mould/LoadMould: $responseJson");
      this.responseJson = responseJson;
      _reloadListView();
    });

    HttpDigger().postWithUri("Mould/LoadLockCodes",
        parameters: {},
        success: (int code, String message, dynamic responseJson) {
      print("Mould/LoadLockCodes: $responseJson");
      this.arrOfData = (responseJson["Extend"] as List).map((item) => MoldLockCodeModel.fromJson(item)).toList();
      print("this.arrOfData: ${this.arrOfData}");
    });
  }

  void _reloadListView() {
    for (int i = 0; i < 4; i++) {
      MESSelectionItemWidget w = this.selectionItemList[i];
      String content = "";
      if (i == 0) {
        content = avoidNull(this.responseJson["MouldNo"]);
      } else if (i == 1) {
        content = avoidNull(this.responseJson["MouldName"]);
      } else if (i == 2) {
        content = avoidNull(this.responseJson["MouldStatus"]);
      } else if (i == 3) {
        content = avoidNull(this.responseJson["HoldStateDes"]);
      }
      w.setContent(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具锁定"),
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
              child: Text("锁定"),
              onPressed: () {
                _btnConfirmClicked();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    List<Widget> children = List();
    for (int i = 0; i < this.selectionItemList.length; i++) {
      children.add(this.selectionItemList[i]);
    }
    children.add(_buildContentInputItem());
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildContentInputItem() {
    void Function (String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.content = newContent;
    };
    return MESConntenInputWidget(placeholder: "备注", contentChangedBlock: contentChangedBlock,);
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
    String content = "";
    if (index == 0) {
      enabled = false;
      title = "模号";
    } else if (index == 1) {
      enabled = false;
      title = "模具名称";
    } else if (index == 2) {
      enabled = false;
      title = "状态";
    } else if (index == 3) {
      enabled = false;
      title = "锁定状态";
    } else if (index == 4) {
      enabled = true;
      title = "锁定代码";
    }

    void Function () selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(enabled: enabled, title: title, selected: false, selectionBlock: selectionBlock,);
    return item;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");
    this.selectedIndex = index;
    for (int i = 0; i < this.selectionItemList.length; i++) {
       MESSelectionItemWidget wgt = this.selectionItemList[index];
       wgt.setSelected((this.selectedIndex == i));
    }
  }

  Future _btnConfirmClicked() async {
    bool isOkay = await AlertTool.showStandardAlert(context, "确定锁定?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    
  }
}