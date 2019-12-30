import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/View/SearchBar.dart';

class ProjectAddMaterialTagPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectAddMaterialTagPageState();
  }
}

class _ProjectAddMaterialTagPageState extends State<ProjectAddMaterialTagPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchBar _sBar = SearchBar(
    hintText: "LOT NO或载具ID",
  );
  List arrOfData;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

     _sBar.keyboardReturnBlock = (String c) {
      _getDataFromServer();
    };
  }

  void _getDataFromServer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("选择物料"),
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
              child: Text("添加"),
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
                          "标签：D20180404000006",
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
                        Text("物料ID：13251001",
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
                        Text("物料批次：20180404",
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
                        Text("订单号：P228217",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("单位：UNT",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
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
                        Text("已上料：82",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("使用量：20",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
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
          Opacity(
            opacity: (this.selectedIndex == index) ? 1.0 : 0.0,
            child: Container(
              margin: EdgeInsets.only(right: 8),
              color: Colors.white,
              child: Icon(
                Icons.check,
                color: hexColor(MAIN_COLOR),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {
    this.selectedIndex = index;
    setState(() {      
    });
  }

  Future _btnConfirmClicked() async {
    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定添加?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {

  }
}