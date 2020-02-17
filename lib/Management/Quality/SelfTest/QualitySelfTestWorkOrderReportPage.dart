import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/MESContentInputWidget.dart';

import '../Model/QualitySelfTestWorkOrderItemModel.dart';

class QualitySelfTestWorkOrderReportPage extends StatefulWidget {
  QualitySelfTestWorkOrderReportPage(this.detailData);
  final QualitySelfTestWorkOrderItemModel detailData;

  @override
  State<StatefulWidget> createState() {
    return _QualitySelfTestWorkOrderReportPageState(detailData);
  }
}

class _QualitySelfTestWorkOrderReportPageState
    extends State<QualitySelfTestWorkOrderReportPage> {
  _QualitySelfTestWorkOrderReportPageState(
    this.detailData,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final QualitySelfTestWorkOrderItemModel detailData;

  String remarkContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("自检工单报工"),
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
      children: <Widget>[
        WidgetTool.createListViewLine(5, hexColor("f2f2f7")),
        _buildWorkOrderHeaderCell(),
        WidgetTool.createListViewLine(1, hexColor("f2f2f7")),
        _buildDetailInfoCell(),
        WidgetTool.createListViewLine(15, hexColor("f2f2f7")),
        _buildSelectionItemCell(title: "机    型：", index: 0),
        _buildMachineBaseJudgementInfoCell(),
        _buildMachineStandardInfoCell(),
        _buildConsequeceNumberInputCell(),
        _buildContentInputCell(),
        WidgetTool.createListViewLine(20, hexColor("f2f2f7")),
      ],
    );
  }

  Widget _buildWorkOrderHeaderCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${this.detailData.LineName}|${this.detailData.Item}",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: hexColor("333333")),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInfoCell() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工序：${this.detailData.Step}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
                Text(
                  "项目：${this.detailData.Item}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工具：${this.detailData.MethodTool}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工单号：${this.detailData.MECWorkOrderNo}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工单类型：${this.detailData.AppWoType}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工单下发时间：${this.detailData.AppTime}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionItemCell(
      {String title = "",
      int index = 0,
      bool shouldShow = true,
      bool canInteract = true}) {
    return Offstage(
      offstage: !shouldShow,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: hexColor(MAIN_COLOR_BLACK),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _buildSelectChoiseItem(index, canInteract),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectChoiseItem(int index, bool canInteract) {
    return GestureDetector(
      onTap: () {
        if (canInteract == false) {
          return;
        }
        print("_buildSelectChoiseItem: $index");
        _hasSelectedChoiseItem(index);
      },
      child: Container(
        color: Colors.white,
        height: 60,
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
          decoration: BoxDecoration(
            color: canInteract ? Colors.white : hexColor("f5f5f5"),
            border: new Border.all(width: 1, color: hexColor("999999")),
            borderRadius: new BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  _getChoiseItemContent(index),
                  style: TextStyle(
                      color: hexColor(MAIN_COLOR_BLACK), fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Offstage(
                offstage: !canInteract,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: Image(
                    width: 10,
                    height: 10,
                    image: AssetImage("Others/Images/downward_triangle.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMachineBaseJudgementInfoCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "判断基准：",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildMachineStandardInfoCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "标    准：",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildConsequeceNumberInputCell() {
    return Container(
      height: 50,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "结    果：",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(width: 1, color: hexColor("999999")),
                    borderRadius: new BorderRadius.all(Radius.circular(4))),
                child: TextField(
                    enabled: true,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                        fontSize: 15, color: hexColor(MAIN_COLOR_BLACK)),
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: "请输入数值(只能输入数值)", border: InputBorder.none),
                    onChanged: (text) {
                      print("contentChanged: $text");
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentInputCell() {
    void Function(String newContent) contentChangedBlock = (String newContent) {
      print("_buildContentInputCell: $newContent");
      this.remarkContent = newContent;
    };
    MESContentInputWidget wgt = MESContentInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
    return wgt;
  }

  void _hasSelectedChoiseItem(int index) {}

  String _getChoiseItemContent(int index) {
    return "-";
  }

  void _btnConfirmClicked() {}
}
