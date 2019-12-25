import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';
import '../../../Others/View/SearchBarWithFunction.dart';
import '../../../Others/View/MESSelectionItemWidget.dart';
import '../../../Others/View/MESConntenInputWidget.dart';

import 'Model/MoldInModel.dart';

class MoldInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldInPageState();
  }
}

class _MoldInPageState extends State<MoldInPage> {
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "模具编码",
  );
  String content;
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  Map responseJson = Map();
  MoldInModel detailData = MoldInModel.fromJson({});

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
  }

  void _reloadListView() {
    for (int i = 0; i < 5; i++) {
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
      } else if (i == 4) {
        content = avoidNull(this.responseJson["StorageStateDes"]);
      }
      w.setContent(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具入库"),
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
            child: Text("入库"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: this.selectionItemList,
    );
  }

  Widget _buildContentInputItem() {
    void Function(String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.content = newContent;
    };
    return MESConntenInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
    String content = "";
    if (index == 0) {
      enabled = false;
      title = "模号";
      content = avoidNull(this.responseJson["MouldNo"]);
    } else if (index == 1) {
      enabled = false;
      title = "模具名称";
      content = avoidNull(this.responseJson["MouldName"]);
    } else if (index == 2) {
      enabled = false;
      title = "状态";
      content = avoidNull(this.responseJson["MouldStatus"]);
    } else if (index == 3) {
      enabled = false;
      title = "锁定状态";
      content = avoidNull(this.responseJson["HoldStateDes"]);
      print("this.responseJson[HoldStateDes]: $content");
    } else if (index == 4) {
      enabled = false;
      title = "出入库状态";
      content = avoidNull(this.responseJson["StorageStateDes"]);
    }

    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(
      enabled: enabled,
      title: title,
      content: content,
      selected: false,
      selectionBlock: selectionBlock,
    );
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

  void _btnConfirmClicked() {}
}
