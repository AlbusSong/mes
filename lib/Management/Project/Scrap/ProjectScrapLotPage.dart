import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import '../../../Others/Const/Const.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../../Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/View/MESSelectionItemWidget.dart';
import '../../../Others/View/MESContentInputWidget.dart';
import '../Widget/ProjectTextInputWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';

import '../Model/ProjectLotInfoModel.dart';
import '../Model/ProjectScrapItemModel.dart';
import '../Model/ProjectReturnRepairmentReasonProcessItemModel.dart';

import 'package:mes/Others/Page/TakePhotoForOCRPage.dart';

import 'package:image_picker/image_picker.dart';

class ProjectScrapLotPage extends StatefulWidget {
  ProjectScrapLotPage(
    this.parentScaffoldKey,
  );
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<StatefulWidget> createState() {
    return _ProjectScrapLotPageState(parentScaffoldKey);
  }
}

class _ProjectScrapLotPageState extends State<ProjectScrapLotPage>
    with AutomaticKeepAliveClientMixin {
  _ProjectScrapLotPageState(
    this.parentScaffoldKey,
  );
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProjectTextInputWidget _pTextInputWgt0;

  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;
  MESSelectionItemWidget _selectionWgt3;

  MESContentInputWidget _contentInputWgt;

  final List<String> bottomFunctionTitleList = ["二维码", "OCR"];

  String remarkContent;
  String lotNo;
  ProjectLotInfoModel lotInfoData;
  List arrOfScrapCode;
  ProjectScrapItemModel selectedScrapCode;
  ProjectReturnRepairmentReasonProcessItemModel reasonProcessInfo;
  File obtainedPicture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _pTextInputWgt0 = _buildTextInputWidgetItem(0);

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);
    _selectionWgt3 = _buildSelectionInputItem(3);

    _contentInputWgt = _buildContentInputItem();

    _getRepairCodeListFromServer();
  }

  void _getDataFromServer() {
    HudTool.show();
    HttpDigger().postWithUri("Repair/SGetLotInfo",
        parameters: {"lotno": this.lotNo}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("Repair/SGetLotInfo: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();

      List arr = responseJson["Extend"];
      if (listLength(arr) > 0) {
        this.lotInfoData = ProjectLotInfoModel.fromJson(arr.first);

        _selectionWgt0.setContent(this.lotInfoData.Wono);
        _selectionWgt1.setContent(
            '${this.lotInfoData.ItemCode}|${this.lotInfoData.ProcessName}');
        _selectionWgt2.setContent(this.lotInfoData.Qty.toString());
      }

      List arr2 = responseJson["Extend2"];
      if (listLength(arr2) > 0) {
        this.reasonProcessInfo =
            ProjectReturnRepairmentReasonProcessItemModel.fromJson(arr2.first);
        _selectionWgt1.setContent(
            '${this.reasonProcessInfo.StepCode}|${this.reasonProcessInfo.StepName}');
      }
    });
  }

  void _getRepairCodeListFromServer() {
    HttpDigger()
        .postWithUri("Repair/GetScrapCode", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("Repair/GetScrapCode: $responseJson");
      this.arrOfScrapCode = (responseJson["Extend"] as List)
          .map((item) => ProjectScrapItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: randomColor(),
      child: Column(
        children: <Widget>[
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
              child: Text("报废"),
              onPressed: () {
                _btnConfirmClicked();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        _pTextInputWgt0,
        _selectionWgt0,
        _selectionWgt1,
        _selectionWgt2,
        _selectionWgt3,
        _contentInputWgt,
        _buildImageInputCell(),
        _buildFooter(),
      ],
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    String title = "";
    String placeholder = "";
    bool canScan = true;
    if (index == 0) {
      title = "LotNo/载具";
      placeholder = "请输入/扫描";
    }
    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: canScan,
    );

    wgt.keyboardReturnBlock = (String c) {
      this.lotNo = c;
      _getDataFromServer();
    };

    wgt.functionBlock = () {
      _popSheetAlert();
    };

    return wgt;
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    if (index == 0) {
      title = "工单";
      enabled = false;
    } else if (index == 1) {
      title = "原因工序";
    } else if (index == 2) {
      title = "数量";
      enabled = false;
    } else if (index == 3) {
      title = "报废代码";
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

  Widget _buildImageInputCell() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 40,
            child: FlatButton(
            textColor: hexColor("333333"),
            color: hexColor("dddddd"),
            child: Text("上传图片"),
            onPressed: () {
              _tryToGetImage();
            },
          ),
          ),

          _buildImageContentArea(),          
        ],
      ),
    );
  }

  Widget _buildImageContentArea() {
    if (this.obtainedPicture == null) {
      return Container(
        height: 1,
      );
    } else {
      return Container(
        margin: EdgeInsets.all(10),
        height: 200,
        color: randomColor(),
        child: Image.file(this.obtainedPicture),
      );
    }
  }

  void _tryToGetImage() {
    print("_tryToGetImage");
    _popSheetAlertForImage();    
  }

  void _popSheetAlertForImage() {
    List<String> titleList = ["相册", "拍照"];
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
                  child: Text(titleList[index])),
              onTap: () {
                print('tapped item ${index + 1}');
                Navigator.pop(context);
                _tryToObtainImage(index);
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToObtainImage(int index) async {
    print("_tryToChooseImage");
    var picture = await ImagePicker.pickImage(source: (index == 0 ? ImageSource.gallery : ImageSource.camera));
    print("picture: $picture");
    if (picture == null) {
      return;
    }

    this.obtainedPicture = picture;

    setState(() {      
    });
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");

    List<String> arrOfSelectionTitle = [];
    if (index == 3) {
      for (ProjectScrapItemModel m in this.arrOfScrapCode) {
        arrOfSelectionTitle.add('${m.ScrapCode}');
      }
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
        cancelText: "取消",
        confirmText: "确定",
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List indexOfSelectedItems) {
          print(indexOfSelectedItems.first);
          print(picker.getSelectedValues());
          this._handlePickerConfirmation(indexOfSelectedItems.first,
              picker.getSelectedValues().first, index);
        });
    // picker.show(Scaffold.of(context));
    picker.show(parentScaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 3) {
      this.selectedScrapCode = this.arrOfScrapCode[indexOfSelectedItem];
      _selectionWgt3.setContent(title);
    }
  }

  Widget _buildContentInputItem() {
    void Function(String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.remarkContent = newContent;
    };
    return MESContentInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      // color: randomColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "【注意事项】",
            style: TextStyle(fontSize: 18, color: hexColor("666666")),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            // color: randomColor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '>未流出构成Lot的报废，请在"工程"中报废',
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  '>已流出Lot的报废，请在"流出"中报废',
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  '>已流出Lot部分报废，请先"分批"后再报废',
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _btnConfirmClicked() async {
    if (this.lotInfoData == null) {
      HudTool.showInfoWithStatus("请先获取Lot信息");
      return;
    }

    if (this.selectedScrapCode == null) {
      HudTool.showInfoWithStatus("请选择报废代码");
      return;
    }

    if (this.remarkContent == null) {
      HudTool.showInfoWithStatus("请填写备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(
        parentScaffoldKey.currentContext, "确认报废？");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    Map mDict = Map();
    mDict["Wono"] = this.lotInfoData.Wono;
    mDict["LotNo"] = this.lotNo;
    mDict["StepCode"] = this.lotInfoData.ItemCode;
    mDict["Comment"] = this.remarkContent;
    mDict["Qty"] = this.lotInfoData.Qty.toString();
    mDict["ScrapCode"] = this.selectedScrapCode.ScrapCode;
    if (this.obtainedPicture != null) {
      mDict["myPic"] = base64Encode(this.obtainedPicture.readAsBytesSync());
      mDict["myFile"] = "${randomIntWithRange(100000, 1000000).toString()}.png";
    } else {
      mDict["myPic"] = "";
      mDict["myFile"] = "";
    }    

    HudTool.show();
    HttpDigger().postWithUri("Repair/ScrapLot", parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
      print("Repair/ScrapLot: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("报废成功");
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
                if (index == 0) {
                  _tryToScan();
                } else if (index == 1) {
                  _tryToUseOCR();
                }
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToUseOCR() async {
    print("_tryToUseOCR");
    // TakePhotoForOCRPage 
    var c = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TakePhotoForOCRPage()));
    print("cccccc: $c");
    if (c == null) {
      return;
    }
    this.lotNo = c;
    _pTextInputWgt0.setContent(this.lotNo);
    _getDataFromServer();
  }

  Future _tryToScan() async {
    print("start scanning");
    
    String c = await BarcodeScanTool.tryToScanBarcode();
    _pTextInputWgt0.setContent(c);
    this.lotNo = c;
    _getDataFromServer();
  }
}
