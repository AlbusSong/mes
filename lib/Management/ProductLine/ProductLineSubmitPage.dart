import 'package:flutter/material.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Tool/WidgetTool.dart';
import '../../Others/Const/Const.dart';

class ProductLineSubmitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductLineSubmitPageState();
  }
}

class _ProductLineSubmitPageState extends State<ProductLineSubmitPage> {
  String content;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("状态变更"),
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
        _buildSelectionItemCell("产线信息:", 0, false, true),
        _buildSelectionItemCell("当前状态:", 1, false, false),
        _buildSelectionItemCell("生产机型:", 2, false, false),
        WidgetTool.createListViewLine(1, hexColor("dddddd")),
        _buildSelectionItemCell("状态变更:", 0, false, true),
        WidgetTool.createListViewLine(1, hexColor("dddddd")),
        _buildContentInputItemCell("备注:        "),
      ],
    );
  }

  Widget _buildSelectionItemCell(
      String title, int index, bool offstage, bool canInteract) {
    return Offstage(
      offstage: offstage,
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
      },
      child: Container(
        color: Colors.white,
        height: 60,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          // color: Colors.white,
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
                  "",
                  style: TextStyle(
                      color: hexColor(MAIN_COLOR_BLACK), fontSize: 17),
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

    Widget _buildContentInputItemCell(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
            child: _buildContenInputItem(
                "备注",
                (String newContent) {
              print("_buildContenInputItem: $newContent");
              this.content = newContent;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContenInputItem(
      String placeholder, void Function(String) textChangedHandler) {
    return Container(
      color: Colors.white,
      height: 140,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor("999999")),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            style: TextStyle(fontSize: 17, color: hexColor("333333")),
            maxLines: 5,
            decoration: InputDecoration(
                hintText: placeholder, border: InputBorder.none),
            onChanged: (text) {
              print("the text: $text");
              this.content = text;
            },
          ),
        ),
      ),
    );
  }

  void _btnConfirmClicked() {}
}
