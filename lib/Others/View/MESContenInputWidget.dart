import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';
import '../Const/Const.dart';


class MESContenInputWidget extends StatefulWidget {
  MESContenInputWidget({
    this.placeholder,
    this.contentChangedBlock,
  });

  final String placeholder;
  void Function (String newContent) contentChangedBlock;

  @override
  State<StatefulWidget> createState() {
    return _MESContenInputWidgetState(placeholder: this.placeholder, contentChangedBlock:this.contentChangedBlock);
  }  
}

class _MESContenInputWidgetState extends State<MESContenInputWidget> {
  _MESContenInputWidgetState({
    this.placeholder,
    this.contentChangedBlock,
  });

  final String placeholder;
  void Function (String newContent) contentChangedBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 140,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor("999999")),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            enabled: true,
            style: TextStyle(fontSize: 17, color: hexColor(MAIN_COLOR_BLACK)),
            maxLines: 5,
            decoration:
                InputDecoration(hintText: this.placeholder, border: InputBorder.none),
            onChanged: (text) {
              print("contentChanged: $text");
              if (this.contentChangedBlock != null) {
                this.contentChangedBlock(text);
              }
            }
          ),
        ),
      ),
    );
  }
}