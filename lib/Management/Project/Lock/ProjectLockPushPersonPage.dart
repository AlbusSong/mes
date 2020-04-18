import 'package:flutter/material.dart';
import '../../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';

import '../Model/ProjectPushPersonItemModel.dart';

class ProjectLockPushPersonPage extends StatefulWidget {
  ProjectLockPushPersonPage(
    this.lineList
  );
  final List lineList;
  @override
  State<StatefulWidget> createState() {
    return _ProjectLockPushPersonPagePageState(this.lineList);
  }
}

class _ProjectLockPushPersonPagePageState
    extends State<ProjectLockPushPersonPage> {
  _ProjectLockPushPersonPagePageState(
    this.lineList
  );
  final List lineList;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List arrOfData;
  List selectionList = List();

  @override
  void dispose() {
    super.dispose();

    HttpDigger().cancelAllRequest();
  }

  @override
  void initState() {
    super.initState();

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // LotSubmit/GetPushPerson
    HudTool.show();
    HttpDigger()
        .postWithUri("LotSubmit/GetPushPerson", parameters: {"lineList": this.lineList}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetPushPerson: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => ProjectPushPersonItemModel.fromJson(item))
          .toList();
      
      setState(() {        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("选择推送人"),
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
            child: Text("选择"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }

  Widget _buildListItem(int index) {
    ProjectPushPersonItemModel itemData = this.arrOfData[index];
    return Container(
      height: 50,
      color: index % 2 == 0 ? Colors.white : hexColor("f1f1f7"),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            itemData.Comment,
            style: TextStyle(color: hexColor("333333"), fontSize: 16),
          ),

          Offstage(
            offstage: this.selectionList.contains(index) == false,
            child: Icon(Icons.done, color: hexColor(MAIN_COLOR), size: 20,),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {
    if (this.selectionList.contains(index)) {
      this.selectionList.remove(index);
    } else {
      this.selectionList.add(index);
    }

    setState(() {      
    });
  }

  void _btnConfirmClicked() {
    if (listLength(this.selectionList) == 0) {
      HudTool.showInfoWithStatus("请至少选择一项");
      return;
    }

    List resultArray = List();
    for (int i = 0; i < listLength(this.selectionList); i++) {
      resultArray.add(this.arrOfData[this.selectionList[i]]);
    }
    Navigator.of(context).pop(resultArray);
  }
}
