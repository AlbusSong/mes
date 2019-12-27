import 'package:flutter/material.dart';
import 'package:mes/Management/Mold/Model/MoldLockCodeModel.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/AlertTool.dart';
import '../../Others/Network/HttpDigger.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import '../../Others/View/MESContentInputWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_picker/flutter_picker.dart';

 import 'Model/MoldLockCodeModel.dart';

class MoldLockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldLockPageState();
  }
}

class _MoldLockPageState extends State<MoldLockPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "模具编码",
  );
  Map responseJson = Map();
  String moldCode;
  String content;
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  List arrOfLockCode;
  MoldLockCodeModel selectedLockCode;

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.moldCode = c;
      _getDataFromServer();
    };

    for (int i = 0; i < 5; i++) {
      this.selectionItemList.add(_buildSelectionItem(i));
    }

    _getAdditionalDataFromServer();
  }

  void _getDataFromServer() {
    HudTool.show();
    HttpDigger().postWithUri("Mould/LoadMould",
        parameters: {"mouldCode": this.moldCode},
        success: (int code, String message, dynamic responseJson) {
      print("Mould/LoadMould: $responseJson");
      HudTool.dismiss();
      this.responseJson = responseJson;
      _reloadListView();
    });
  }

  void _getAdditionalDataFromServer() {
    HttpDigger()
        .postWithUri("Mould/LoadLockCodes", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print('Mould/LoadLockCodes: ${responseJson["Extend"]}');
      this.arrOfLockCode = (responseJson['Extend'] as List)
          .map((item) => MoldLockCodeModel.fromJson(item))
          .toList();
    });
  }

  void _reloadListView() {
    for (int i = 0; i < 4; i++) {
      MESSelectionItemWidget w = this.selectionItemList[i];
      String c = "";
      if (i == 0) {
        c = avoidNull(this.responseJson["MouldNo"]);
      } else if (i == 1) {
        c = avoidNull(this.responseJson["MouldName"]);
      } else if (i == 2) {
        c = avoidNull(this.responseJson["MouldStatus"]);
      } else if (i == 3) {
        c = avoidNull(this.responseJson["HoldStateDes"]);
      }
      w.setContent(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
    void Function(String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.content = newContent;
    };
    return MESContentInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
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

    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(
      enabled: enabled,
      title: title,
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

    if (index == 4) {
      List<String> arrOfSelectionTitle = [];
      for (MoldLockCodeModel m in this.arrOfLockCode) {
        arrOfSelectionTitle.add("${m.LockCode}|${m.Description}");
      }
      _showPickerWithData(arrOfSelectionTitle, index);
    }

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
          this._handlePickerConfirmation(indexOfSelectedItems.first, index);
        });
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(int indexOfSelectedItem, int index) {
    if (index == 4) {
      this.selectedLockCode = this.arrOfLockCode[indexOfSelectedItem];
      MESSelectionItemWidget wgt = this.selectionItemList[4];
      wgt.setContent(
          "${this.selectedLockCode.LockCode}|${this.selectedLockCode.Description}");
    }
  }

  Future _btnConfirmClicked() async {
    if (isAvailable(this.moldCode) == false ||
        this.responseJson.isNotEmpty == false) {
      HudTool.showInfoWithStatus("请先获取模具信息");
      return;
    }

    if (this.selectedLockCode == null) {
      HudTool.showInfoWithStatus("请选择锁定代码");
      return;
    }

    if (isAvailable(this.content) == false) {
      HudTool.showInfoWithStatus("请填写备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(context, "确定锁定?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    HudTool.show();
    HttpDigger().postWithUri("Mould/Lock", parameters: {
      "mouldCode": this.moldCode,
      "lockCode": this.selectedLockCode.LockCode,
      "remark": this.content
    }, success: (int code, String message, dynamic responseJson) {
      print("Mould/Lock: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus(message);
      Navigator.pop(context);
    });
  }

  void _popSheetAlert() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: ListView(
            children: List.generate(
          2,
          (index) => InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  child: Text(bottomFunctionTitleList[index])),
              onTap: () {
                print('tapped item ${index + 1}');
                Navigator.pop(context);
                _tryToscan();
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToscan() async {
    print("start scanning");

    try {
      this.moldCode = await BarcodeScanner.scan();
      _getDataFromServer();
    } on Exception catch (e) {
      if (e == BarcodeScanner.CameraAccessDenied) {
        HudTool.showInfoWithStatus("相机权限未开启");
      } else {
        HudTool.showInfoWithStatus("未知错误");
      }
    } on FormatException {
      HudTool.showInfoWithStatus("一/二维码的值为空，请检查");
    } catch (e) {
      HudTool.showInfoWithStatus("未知错误");
    }
  }
}
