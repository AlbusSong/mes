import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';
import '../Const/Const.dart';

class MESSelectionItemWidget extends StatefulWidget {
  MESSelectionItemWidget(
    {
      this.enabled = true,
      this.title = "",
      this.content = "-",
      this.selected = false,
      this.selectionBlock,
    }
  );

  void setEnabled(bool e) {
    this.enabled = e;
    _theState.setEnabled(e);
  }

  void setSelected(bool s) {
    this.selected = s;
    _theState.setSelected(s);
  }

  bool enabled;
  String title;
  String content;
  bool selected;
  void Function () selectionBlock;

  _MESSelectionItemWidgetState _theState;

  @override
  State<StatefulWidget> createState() {
    _theState = _MESSelectionItemWidgetState(enabled: this.enabled, title: this.title, content: this.content, selected: this.selected, selectionBlock: this.selectionBlock);
    return _theState;
  }
}

class _MESSelectionItemWidgetState extends State<MESSelectionItemWidget> {
  _MESSelectionItemWidgetState(
    {
      this.enabled,
      this.title,
      this.content,
      this.selected,
      this.selectionBlock,
    }
  );

  void setEnabled(bool e) {
    setState(() {
      this.enabled = e;
    });
  }

  void setSelected(bool s) {
    setState(() {
      this.selected = s;
    });
  }

  bool enabled;
  String title;
  String content;
  bool selected;
  void Function () selectionBlock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.enabled == false) {
          return;
        }
        // print("MESSelectionItemWidget clicked");
        if (this.selectionBlock != null) {
          this.selectionBlock();
        }
      },
      child: Container(
      color: (this.enabled == true ? Colors.white : hexColor("d3d3d3")),
      height: 60,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 45,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 3),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: new Border.all(width: 1, color: this.selected ? hexColor(MAIN_COLOR) : hexColor("999999")),
              borderRadius: new BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    this.content,
                    style: TextStyle(color: hexColor("333333"), fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Offstage(
                  offstage: (this.enabled == true ? false : true),
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
          Positioned(
            top: 3,
            left: 20,
            child: Container(
              color: (this.enabled == true ? Colors.white : hexColor("d3d3d3")),
              child: Text(
                this.title,
                style: TextStyle(fontSize: 15, color: hexColor("333333")),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
