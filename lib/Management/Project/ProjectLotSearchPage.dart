import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';

import 'dart:convert';

import 'Model/ProjectItemModel.dart';

class ProjectLotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotSearchPageState();
  }
}

class _ProjectLotSearchPageState extends State<ProjectLotSearchPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );
  String lotNo;
  ProjectItemModel detailData = ProjectItemModel.fromJson({});

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
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetLotSearch", parameters: {"lotno":this.lotNo}, shouldCache: false, success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetLotSearch: $responseJson");
      HudTool.dismiss();
      List extend = jsonDecode(responseJson["Extend"]);
      if (listLength(extend) == 0) {
        return;
      }
      this.detailData = ProjectItemModel.fromJson(extend[0]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot查询"),
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
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _buildInfoCell(),
      ],
    );
  }

  Widget _buildInfoCell() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
      color: hexColor("d3d3d3"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "物料编码：${avoidNull(this.detailData.ItemCode)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "物料名称：${avoidNull(this.detailData.ItemName)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       工程：${avoidNull(this.detailData.ProcessCode)}|${avoidNull(this.detailData.ProcessName)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       规格：${avoidNull(this.detailData.Dscb)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       档位：${avoidNull(this.detailData.Grade)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "   订单号：${avoidNull(this.detailData.OrderNo)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       状态：${avoidNull(this.detailData.StatusDesc)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "工单编号：${avoidNull(this.detailData.Wono)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "  Lot大小：${this.detailData.LOTSize}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       数量：${this.detailData.Qty}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "锁定状态：${avoidNull(this.detailData.HoldDesc)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "锁定编码：${avoidNull(this.detailData.HoldCode)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       产线：${avoidNull(this.detailData.LineCode)}|${avoidNull(this.detailData.LineName)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "作业中心：${avoidNull(this.detailData.WorkCenterCode)}|${avoidNull(this.detailData.WorkCenterName)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "生成时间：${avoidNull(this.detailData.CTime)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "完成时间：${avoidNull(this.detailData.OTime)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "       备注：${avoidNull(this.detailData.Comment)}",
              style: TextStyle(color: hexColor("333333"), fontSize: 15),
            ),
          ),
        ],
      ),
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
