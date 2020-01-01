import 'package:flutter/material.dart';
import '../../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';
import '../../../Others/View/SelectionBar.dart';

import 'package:flutter_picker/flutter_picker.dart';

import 'ProjectRepairmentDetailPage.dart';

import '../Model/ProjectProcessItemModel.dart';

class ProjectRepairmentListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectRepairmentListPageState();
  }
}

class _ProjectRepairmentListPageState extends State<ProjectRepairmentListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SelectionBar _sBar = SelectionBar();

  String lotNo;
  List arrOfProcess;
  ProjectProcessItemModel selectedProcess;

  @override
  void initState() {
    super.initState();

    _sBar.setSelectionBlock(() {
      print("setSelectionBlock");
      List<String> arrOfSelectionTitle = [];
      for (ProjectProcessItemModel m in this.arrOfProcess) {
        arrOfSelectionTitle.add('${m.ProcessCode}|${m.ProcessName}');
      }

      if (arrOfSelectionTitle.length == 0) {
        return;
      }

      _showPickerWithData(arrOfSelectionTitle, 0);
    });

    _getProcessListFromServer();
  }

  void _getDataFromServer() {
    HudTool.show();
    HttpDigger()
        .postWithUri("Repair/GetRepairList", parameters: {"workcenter":this.selectedProcess.WorkCenter, "lotno":"", "rpwo":""}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("Repair/GetRepairList: $responseJson");
      HudTool.dismiss();
      // this.arrOfProcess = (responseJson['Extend'] as List)
      //     .map((item) => ProjectProcessItemModel.fromJson(item))
      //     .toList();
    });
  }

  void _getProcessListFromServer() {
    HudTool.show();
    HttpDigger()
        .postWithUri("Repair/GetAllProcess", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("Repair/GetAllProcess: $responseJson");
      HudTool.dismiss();
      this.arrOfProcess = (responseJson['Extend'] as List)
          .map((item) => ProjectProcessItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("修理清单"),
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
    return ListView.builder(
        // itemCount: listLength(this.arrOfData),
        itemCount: 10,
        itemBuilder: (context, index) {
          // In our case, a DogCard for each doggo.
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }

  Widget _buildListItem(int index) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    height: 25,
                    color: Colors.white,
                    child: Text(
                      "返修工单：D20180404000006",
                      maxLines: 2,
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR_BLACK),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("LotNo：13251001",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("生产工单：20180404",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("机型：20180404",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("创建时间：20180404",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("数量：82",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("返修代码：20",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: hexColor("dddddd"),
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(right: 8),
            color: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: hexColor("dddddd"),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
        builder: (BuildContext context) => ProjectRepairmentDetailPage()));
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
    // picker.show(Scaffold.of(context));
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    _sBar.setContent(title);
    this.selectedProcess = this.arrOfProcess[indexOfSelectedItem];

    _getDataFromServer();
  }
}