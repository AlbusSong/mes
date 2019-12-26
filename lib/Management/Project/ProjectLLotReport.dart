import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'Widget/ProjectTextInputWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';

class ProjectLLotReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLLotReportState();  
  }
}

class _ProjectLLotReportState extends State<ProjectLLotReport> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    // for (int i = 0; i < 8; i++) {
    //   this.selectionItemList.add(_buildSelectionItem(i));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot报工"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }  

  Widget _buildBody() {
    return Column(
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
              child: Text("确认"),
              onPressed: () {
                // _btnConfirmClicked();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        // _buildTextInputWidgetItem(0),
        // ProjectTextInputWidget(title: "体贴", placeholder: "ycucus", canScan: false,),
      ],      
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    ProjectTextInputWidget wgt = ProjectTextInputWidget(title: "标题", placeholder: "hhhha", canScan: true,);

    wgt.functionBlock = () {
      print(".............asd");
      hideKeyboard(context);
    };
    wgt.contentChangeBlock = (String newContent) {
      print("contentChangeBlock: $newContent");
    };

    return wgt;
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
      String c = await BarcodeScanner.scan();
      print("c: $c");
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