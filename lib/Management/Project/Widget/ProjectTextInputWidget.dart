import 'package:flutter/material.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';

class ProjectTextInputWidget extends StatelessWidget {
  ProjectTextInputWidget({
    this.title = "",
    this.placeholder = "输入",
    this.canScan = true,
  });

  String title;
  String placeholder;
  bool canScan;
  void Function() functionBlock;
  void Function(String newContent) contentChangeBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 45,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 3),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(width: 1, color: hexColor("999999")),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      style: TextStyle(fontSize: 17, color: hexColor("333333")),
                      decoration: InputDecoration(
                          hintText: this.placeholder,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 0)),
                      onChanged: (String text) {
                        print("text: $text");
                        if (this.contentChangeBlock != null) {
                          this.contentChangeBlock(text);
                        }
                      },
                    ),
                  ),
                ),
                Offstage(
                  offstage: (this.canScan == true ? false : true),
                  child: GestureDetector(
                    child: Container(
                      width: 45,
                      // color: randomColor(),
                      child: Center(
                        // child: Icon(Icons.scanner, size: 30, color: hexColor("999999"),),
                        child: Image.asset(
                            "Others/Images/scan_barcode_icon.png",
                            width: 25,
                            height: 25),
                      ),
                    ),
                    onTap: () {
                      print("functionClicked");
                      if (this.functionBlock != null) {
                        this.functionBlock();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 3,
            left: 20,
            child: Container(
              color: Colors.white,
              child: Text(
                this.title,
                style: TextStyle(fontSize: 15, color: hexColor("333333")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
