import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';

class ProjectLotUnlockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotUnlockPageState();
  }
}

class _ProjectLotUnlockPageState extends State<ProjectLotUnlockPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );
  String lotNo;

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.lotNo = c;
      _getDataFromServer();
    };
  }

  void _getDataFromServer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot解锁"),
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
              child: Text("解锁"),
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
      ],
    );
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

    String c = await BarcodeScanTool.tryToScanBarcode();
    _sBar.setContent(c);
    this.lotNo = c;
    _getDataFromServer();
  }
}
